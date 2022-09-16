require('rest-nvim').setup()

vim.api.nvim_set_keymap('n', '<leader>H', '<Plug>RestNvim', {})
vim.api.nvim_set_keymap('n', '<leader>h', '<Plug>RestNvimPreview', {})

