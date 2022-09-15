require("luasnip.loaders.from_vscode").lazy_load()
-- https://zjp-cn.github.io/neovim0.6-blogs/nvim/luasnip/doc1.html
require("luasnip.loaders.from_lua").lazy_load({paths = vim.g.data_root.."/snippets"})
