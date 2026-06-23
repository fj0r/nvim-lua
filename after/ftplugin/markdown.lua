-- Neovim 0.12 ftplugin/markdown.lua auto-calls vim.treesitter.start() which triggers
-- the buggy markdown_inline parser (range errors on injection).
-- Stop it here and fall back to built-in syntax highlighting.
vim.treesitter.stop()
