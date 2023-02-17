require("todo-comments").setup {}
local o = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>ga', '<cmd>TodoTelescope<cr>', o)
vim.keymap.set('n', '<leader>gt', '<cmd>TodoTrouble<cr>', o)
