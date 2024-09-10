local config = require 'lspconfig'

for _, lsp in
ipairs {
    "hls",
    "rust_analyzer",
    "pyright",
    "nushell",
    "julials",
    "metals",
    "ts_ls",
    "gopls",
    "jdtls"
} do config[lsp].setup {} end
