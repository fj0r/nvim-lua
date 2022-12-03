--[[ tcd hook
if 'NVIM' in (env).name {
    nvim --headless --noplugin --server $env.NVIM --remote-send $"<cmd>lua HookPwdChanged\('($after)', '($before)')<cr>"
}
--]]
local vcs_root = require'vcs'.root
function HookPwdChanged(after, before)
    vim.b.pwd = after

    local git_dir = vcs_root(after, nil)
    vim.api.nvim_command('silent tcd! '..(git_dir or after))
end

--[[ $env.EDITOR
#!/usr/bin/env nu

def main [file: string] {
    if 'NVIM' in (env).name {
        nvim --headless --noplugin --server $env.NVIM --remote-wait $file
    } else {
        nvim $file
    }
}
--]]

-- let b:pwd='($PWD)'
function OppositePwd()
    local tab = vim.api.nvim_get_current_tabpage()
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local cwin = vim.api.nvim_tabpage_get_win(tab)

    for _, w in ipairs(wins) do
        if cwin ~= w then
            local b = vim.api.nvim_win_get_buf(w)
            local pwd = vim.b[b].pwd
            if pwd then return pwd end
        end
    end
end

function ReadTempDrop(path, action)
    vim.api.nvim_command(action or 'botright vnew')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_command('read '..path)
    vim.fn.delete(path)
end

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-N>]], { noremap = true, silent = true })
-- Pasting in terminal mode
-- vim.cmd [[tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi']]
vim.api.nvim_set_keymap('t', '<C-y>', '', {
    expr = true,
    callback = function ()
        --require("registers").show_window({ mode = "insert" })
        --vim.api.nvim_command('Registers')
        local t = vim.fn.getreg(vim.fn.nr2char(vim.fn.getchar()))
        local buf = vim.api.nvim_get_current_buf()
        local chan = vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
        vim.api.nvim_chan_send(chan, t)
    end
})
----------------------------------------------------------------------
local M = {}

local log = function (msg)
    if true then
        local notify = require'notify'.notify
        notify(vim.inspect(msg))
    else
        print(vim.inspect(msg))
    end
end

local get_tabpage = function (n)
    for _, i in pairs(vim.api.nvim_list_tabpages()) do
        if vim.api.nvim_tabpage_get_number(i) == n then
            return i
        end
    end
end


local tab_term = {}


function M.get (action, cmd, newtab)
    return function (ctx)
        local tab = vim.api.nvim_get_current_tabpage()
        local tot = tab_term[tab]
        local cnt = vim.v.count
        local shell = vim.fn.getenv('SHELL')
        if tot and tot[cnt] and not newtab then
            local t = tot[cnt]
            local ws = vim.api.nvim_tabpage_list_wins(tab)
            for _, w in ipairs(ws) do
                local b = vim.api.nvim_win_get_buf(w)
                if b == t then
                    vim.api.nvim_set_current_win(w)
                    return
                end
            end

            if action then vim.api.nvim_command(action) end
            local win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_buf(win, tot[cnt])
        else
            if action then vim.api.nvim_command(action) end
            local name = '[' .. cnt .. ']' .. shell .. "://" .. "<b:terminal_job_pid>"
            vim.fn.termopen(shell, {name = name})
            --vim.api.nvim_command('silent tcd! .')
            if newtab then
                tab = vim.api.nvim_get_current_tabpage()
                tot = tab_term[tab]
            end
            if not tot then
                tab_term[tab] = {}
            end
            tab_term[tab][cnt] = vim.api.nvim_get_current_buf()
        end
        local chan = vim.api.nvim_buf_get_var(tab_term[tab][cnt], 'terminal_job_id')
        if ctx then
            vim.api.nvim_chan_send(chan, ctx.args..'\n')
        else
            vim.api.nvim_chan_send(chan, '')
        end
    end
end

function M.prepare (ctx)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.spell = false
    vim.opt_local.ruler = false
    vim.opt_local.showcmd = false
    vim.opt_local.mouse = ''
    --vim.opt_local.hlsearch = false
    vim.opt_local.cursorline = false
    vim.opt_local.lazyredraw = true
    local curr_line = vim.fn.line('.')
    local last_line = vim.fn.line('$')
    local window_line = vim.fn.line('w$') - vim.fn.line('w0')
    -- :FIXME: curr_line == <term_last_line>
    if curr_line == last_line or curr_line < window_line then
        vim.api.nvim_command('startinsert')
    end
end

function M.release(buf)
    for tx, t in pairs(tab_term) do
        for bx, b in pairs(t) do
            if b == buf then
                tab_term[tx][bx] = nil
            end
        end
    end
end

function M.close_tab(tab)
    --local t = get_tabpage(tonumber(tab))
    --if t == nil then return end
    --for _, b in pairs(tab_term[t]) do
    --    vim.api.nvim_buf_delete(b, {})
    --end

    local available = {}

    for _, i in pairs(vim.api.nvim_list_tabpages()) do
        available[i] = true
    end

    local unavailable = {}
    for t, _ in pairs(tab_term) do
        if not available[t] then
            table.insert(unavailable, t)
        end
    end

    for _, u in pairs(unavailable) do
        for _, b in pairs(tab_term[u]) do
            vim.api.nvim_buf_delete(b, {force = true})
        end
        tab_term[u] = nil
    end
end

function M.toggle_taberm()
    local ctab = vim.api.nvim_get_current_tabpage()
    local ctabwins = vim.api.nvim_tabpage_list_wins(ctab)
    local buf2win = {}
    for _, i in pairs(ctabwins) do
        buf2win[vim.api.nvim_win_get_buf(i)] = i
    end
    local termwins = {}
    for _, b in pairs(tab_term[ctab] or {}) do
        if buf2win[b] then
            table.insert(termwins, buf2win[b])
        end
    end
    if #termwins > 0 then
        if #termwins == #ctabwins then
            return
        end
        for _, w in pairs(termwins) do
            vim.api.nvim_win_close(w, {force=true})
        end
    else
        if tab_term[ctab] then
            local first = true
            for _, b in pairs(tab_term[ctab]) do
                if first then
                    first = false
                    vim.api.nvim_command('botright vnew')
                else
                    vim.api.nvim_command('rightbelow new')
                end
                vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), b)
            end
        else
            M.v()
        end
    end
end

function M.debug()
    log(tab_term)
end


M.t  = M.get('tabnew', '', true)
M.v  = M.get('rightbelow vnew', '')
M.V  = M.get('botright vnew', '')
M.c  = M.get('rightbelow new', '')
M.C  = M.get('botright new', '')
M.n  = M.get(nil, '')

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = 'term://*',
    callback = function (ctx)
        M.prepare(ctx)
    end ,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = 'term://*',
    callback = function (ctx)
        M.prepare(ctx)
    end ,
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = 'term://*',
    callback = function (ctx)
        M.release(ctx.buf)
        vim.api.nvim_input('<cr>')
    end
})

vim.api.nvim_create_autocmd("TabClosed", {
    callback = function (ctx)
        M.close_tab(ctx.file)
    end
})

return M
