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

local tbm = require('taberm')

vim.api.nvim_set_keymap('n', '<leader>xx', '', { callback = tbm.t, noremap = true, silent = true, desc = 'new term tab' })
vim.api.nvim_set_keymap('n', '<leader>xv', '', { callback = tbm.v, noremap = true, silent = true, desc = 'new term vertical' })
vim.api.nvim_set_keymap('n', '<leader>xV', '', { callback = tbm.V, noremap = true, silent = true, desc = 'new term vertical ext' })
vim.api.nvim_set_keymap('n', '<leader>xc', '', { callback = tbm.c, noremap = true, silent = true, desc = 'new term' })
vim.api.nvim_set_keymap('n', '<leader>xC', '', { callback = tbm.C, noremap = true, silent = true, desc = 'new term ext' })

vim.api.nvim_create_user_command('X',  tbm.t, { nargs = '?' , desc = 'new term tab'})
vim.api.nvim_create_user_command('Xv', tbm.v, { nargs = '?' , desc = 'new term vertical'})
vim.api.nvim_create_user_command('XV', tbm.V, { nargs = '?' , desc = 'new term vertical ext'})
vim.api.nvim_create_user_command('Xc', tbm.c, { nargs = '?' , desc = 'new term'})
vim.api.nvim_create_user_command('XC', tbm.C, { nargs = '?' , desc = 'new term ext'})

vim.api.nvim_create_user_command('Xdebug', tbm.debug, { nargs = '?' , desc = 'term debug'})
