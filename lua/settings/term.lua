local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-N>]], opt)
vim.api.nvim_set_keymap('n', '<leader>xc', '<cmd>new|terminal<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>xv', '<cmd>vnew|terminal<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>tabnew|terminal<cr>', opt)

vim.api.nvim_create_user_command('T',
    function (x)
        local b = vim.api.nvim_create_buf('', 'terminal')
        vim.api.nvim_set_current_buf(b)
        local t = vim.api.nvim_open_term(b, {})
        --x.args
        vim.api.nvim_chan_send(t, x.args)
    end,
    { nargs = '?' }
)

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = 'term://*',
    callback = function (info)
        local b = vim.bo[info.buf] -- vim.api.nvim_get_current_buf()
        local w = vim.wo[vim.api.nvim_get_current_win()]
        w.number = false
        w.relativenumber = false
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
        vim.cmd'quit'
    end
})

--[[ nvim remote-send
nvim --headless --noplugin --server $NVIM --remote-send '<cmd>tabnew ./init.lua<cr>'
--]]
