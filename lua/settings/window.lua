local m   = vim.api.nvim_set_keymap
local c   = vim.api.nvim_command
local op2 = { noremap = true, silent = true }

m('n', '<C-j>', '<C-W>j', op2)
m('n', '<C-k>', '<C-W>k', op2)
m('n', '<C-h>', '<C-W>h', op2)
m('n', '<C-l>', '<C-W>l', op2)
m('n', '<C-W><C-j>', '<C-W><S-j>', op2)
m('n', '<C-W><C-k>', '<C-W><S-k>', op2)
m('n', '<C-W><C-h>', '<C-W><S-h>', op2)
m('n', '<C-W><C-l>', '<C-W><S-l>', op2)
c('command! -nargs=1 VR :vertical resize <args>')
c('command! -nargs=1 HR :resize <args>')

-- move between tabs
m('n', '<leader>1', '1gt', op2)
m('n', '<leader>2', '2gt', op2)
m('n', '<leader>3', '3gt', op2)
m('n', '<leader>4', '4gt', op2)
m('n', '<leader>5', '5gt', op2)
m('n', '<leader>6', '6gt', op2)
m('n', '<leader>7', '7gt', op2)
m('n', '<leader>8', '8gt', op2)
m('n', '<leader>9', '9gt', op2)
m('n', '<leader>0', '<cmd>tablast<cr>', op2)

m('n', '<M-1>', '1gt', op2)
m('n', '<M-2>', '2gt', op2)
m('n', '<M-3>', '3gt', op2)
m('n', '<M-4>', '4gt', op2)
m('n', '<M-5>', '5gt', op2)
m('n', '<M-6>', '6gt', op2)
m('n', '<M-7>', '7gt', op2)
m('n', '<M-8>', '8gt', op2)
m('n', '<M-9>', '9gt', op2)
m('n', '<M-0>', '<cmd>tablast<cr>', op2)

c('command! -complete=file -nargs=? T :tabnew <args>')
