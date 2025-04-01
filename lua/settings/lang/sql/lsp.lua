vim.lsp.config['postgres_lsp'] = {
    cmd = { "postgrestools", "lsp-proxy" },
    filetypes = { "sql" },
    single_file_support = true,
}

vim.lsp.enable('postgres_lsp')
