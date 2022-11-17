local M = {}

local notify = function (msg)
    local notify = require'notify'.notify
    notify(vim.inspect(msg))
end

local tab_term = {}

function M.get (action, cmd, newtab)
    return function (ctx)
        local tab = vim.api.nvim_get_current_tabpage()
        local tot = tab_term[tab]
        local cnt = vim.v.count
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
            vim.api.nvim_command('terminal '..cmd)
            vim.api.nvim_command('silent tcd! .')
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

function M.debug()
    notify(tab_term)
end


M.t  = M.get('tabnew', '', true)
M.v  = M.get('rightbelow vnew', '')
M.V  = M.get('botright vnew', '')
M.c  = M.get('rightbelow new', '')
M.C  = M.get('botright new', '')
M.n  = M.get(nil, '')

return M
