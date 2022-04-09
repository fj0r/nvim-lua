vim.g.asynctasks_extra_config = {
    vim.g.config_root .. '/asynctask.ini'
}
vim.api.nvim_set_keymap('n', '<leader>t', "<cmd>lua require('telescope').extensions.asynctasks.all()<cr>", { noremap = true })
