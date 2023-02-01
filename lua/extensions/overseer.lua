require'overseer'.setup{

}

local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>ot', '<cmd>OverseerToggle<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>oo', '<cmd>OverseerOpen<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>or', '<cmd>OverseerRun<cr>', opt)
