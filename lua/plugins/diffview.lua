require("diffview").setup({})

local opts = { noremap = true }
vim.keymap.set('n', '<leader>gh', "<cmd>DiffviewFileHistory<cr>", opts)
vim.keymap.set('n', '<leader>gf', "<cmd>DiffviewFileHistory %<cr>", opts)
vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<cr>", opts)
vim.keymap.set('n', '<leader>gx', "<cmd>DiffviewClose<cr>", opts)
