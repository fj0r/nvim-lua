local m   = vim.api.nvim_set_keymap
local op2 = { noremap = true, silent = true }

m('t', '<Esc>', '<C-\\><C-N>', op2)
