require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local o = {silent = true, noremap = true}
vim.api.nvim_set_keymap('n', '<C-t><C-t>', '<cmd>TroubleToggle<cr>', o)
vim.api.nvim_set_keymap("n", "<C-t>w", "<cmd>TroubleToggle workspace_diagnostics<cr>", o)
vim.api.nvim_set_keymap("n", "<C-t>d", "<cmd>TroubleToggle document_diagnostics<cr>", o)
vim.api.nvim_set_keymap("n", "<C-t>l", "<cmd>TroubleToggle loclist<cr>", o)
vim.api.nvim_set_keymap("n", "<C-t>q", "<cmd>TroubleToggle quickfix<cr>", o)
vim.api.nvim_set_keymap("n", "<C-t>r", "<cmd>TroubleToggle lsp_references<cr>", o)
