vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-N>]], { noremap = true, silent = true })
-- Pasting in terminal mode
vim.cmd [[tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi']]

local new_term = function (action, cmd)
    return function (x)
        vim.api.nvim_command(action)
        --vim.api.nvim_win_set_height(0, 10) -- set the window height
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(win, buf)
        vim.api.nvim_command('terminal '..cmd)
        local chan = vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
        if x then
            vim.api.nvim_chan_send(chan, x.args..'\n')
        else
            vim.api.nvim_chan_send(chan, '')
        end
    end
end

-- botright (full width or height)
-- rightbelow
local cnew = new_term('rightbelow new', '')
local vnew = new_term('rightbelow vnew', '')
local xnew = new_term('tabnew', '')

vim.api.nvim_set_keymap('n', '<leader>xc', '', { callback = cnew, noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xv', '', { callback = vnew, noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xx', '', { callback = xnew, noremap = true, silent = true })

vim.api.nvim_create_user_command('X', xnew, { nargs = '?' })
vim.api.nvim_create_user_command('V', vnew, { nargs = '?' })
vim.api.nvim_create_user_command('C', cnew, { nargs = '?' })

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = 'term://*',
    callback = function (info)
        local b = vim.bo[info.buf] -- vim.api.nvim_get_current_buf()
        local w = vim.wo[vim.api.nvim_get_current_win()]
        w.number = false
        w.relativenumber = false
        w.spell = false
        vim.api.nvim_command('startinsert')
    end
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = 'term://*',
    command = 'startinsert'
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = 'term://*',
    callback = function (info)
        vim.api.nvim_input('<cr>')
    end
})

--[[ nvim remote-send
nvim --headless --noplugin --server $NVIM --remote-send '<cmd>tabnew ./init.lua<cr>'
--]]
