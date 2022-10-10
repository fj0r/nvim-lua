vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-N>]], { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = 'term://*',
    callback = function (info)
        local b = vim.bo[info.buf] -- vim.api.nvim_get_current_buf()
        local w = vim.wo[vim.api.nvim_get_current_win()]
        w.number = false
        w.relativenumber = false
        vim.cmd'startinsert'
    end
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = 'term://*',
    callback = function (info)
        vim.cmd'quit'
    end
})
