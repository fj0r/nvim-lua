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

----------------------------------------------------------------------
local M = {}

local notify = function (msg)
    local notify = require'notify'.notify
    notify(vim.inspect(msg))
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
    local t = get_tabpage(tonumber(tab))
    if t == nil then return end
    for _, b in pairs(tab_term[t]) do
        vim.api.nvim_buf_delete(b, {})
    end
end

function M.debug()
    notify(tab_term)
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
