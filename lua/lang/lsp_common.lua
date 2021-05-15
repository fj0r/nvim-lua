local config = require'lspconfig'

for _, lsp in
ipairs { "hls"
       , "rust_analyzer"
       , "pyright"
       , "metals"
       , "tsserver"
       , "gopls"
       , "jdtls"
       , "intelephense"
       } do config[lsp].setup{} end

