require("diffview").setup({})

vim.api.nvim_set_keymap('n', '<leader>gh', "<cmd>DiffviewFileHistory %<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gd', "<cmd>DiffviewOpen<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gx', "<cmd>DiffviewClose<cr>", { noremap = true })
