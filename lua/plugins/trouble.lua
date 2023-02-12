require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local o = {silent = true, noremap = true}
vim.keymap.set('n', '<leader>gt', '<cmd>TroubleToggle<cr>', o)
vim.keymap.set('n', '<leader>gw', '<cmd>TroubleToggle workspace_diagnostics<cr>', o)
vim.keymap.set('n', '<leader>ga', '<cmd>TroubleToggle document_diagnostics<cr>', o)
vim.keymap.set('n', '<leader>gl', '<cmd>TroubleToggle loclist<cr>', o)
vim.keymap.set('n', '<leader>gq', '<cmd>TroubleToggle quickfix<cr>', o)
vim.keymap.set('n', '<leader>gr', '<cmd>TroubleToggle lsp_references<cr>', o)
