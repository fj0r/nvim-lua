vim.api.nvim_create_user_command('ClearReg', function()
    local regs = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, #regs do
        vim.fn.setreg(string.sub(regs, i, i), {})
    end
end, { nargs = '?', desc = 'clear register' })

vim.api.nvim_create_user_command('ClearMark', function()
    vim.api.nvim_command 'delmarks A-Z0-9'
end, { nargs = '?', desc = 'clear mark' })
