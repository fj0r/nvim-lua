vim.api.nvim_create_user_command('Detach', function()
    for _, i in ipairs(vim.api.nvim_list_uis()) do
        vim.fn.chanclose(i.chan)
    end
end, { nargs = '?', desc = 'Detach' })

vim.keymap.set('n', '<M-d>', '<cmd>Detach<CR>', { noremap = true, silent = true })
