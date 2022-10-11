vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-N>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-r>', [["]], { noremap = true, silent = true })

local new_term = function (action, shell)
    return function (x)
        vim.cmd(action)
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(win, buf)
        vim.cmd('terminal '..shell)
        local chan = vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
        if x then
            vim.api.nvim_chan_send(chan, x.args)
        else
            vim.api.nvim_chan_send(chan, '')
        end
    end
end

local cnew = new_term('new', '')
local vnew = new_term('vnew', '')
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
        vim.cmd 'startinsert'
    end
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = 'term://*',
    command = 'startinsert'
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = 'term://*',
    callback = function (info)
        -- vim.cmd'quit'
    end
})

--[[ nvim remote-send
nvim --headless --noplugin --server $NVIM --remote-send '<cmd>tabnew ./init.lua<cr>'
--]]
