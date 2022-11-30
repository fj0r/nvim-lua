local config = require'lspconfig'

for _, lsp in
ipairs { "hls"
       , "rust_analyzer"
       , "pyright"
       , "julials"
       , "metals"
       , "tsserver"
       , "gopls"
       , "jdtls"
       } do config[lsp].setup {} end

