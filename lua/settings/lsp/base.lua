for _, lsp in
ipairs {
    "hls",
    "rust_analyzer",
    "nushell",
    "julials",
    "metals",
    "ts_ls",
    "gopls",
    "jdtls"
} do
    vim.lsp.enable(lsp, {})
end
