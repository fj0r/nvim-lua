require'lspconfig'.jsonls.setup {
}

require'lspconfig'.yamlls.setup {
    schemas = {
        [vim.g.config_root .. '/JSONSchema/compose-spec.json'] = "/docker-compose.yml",
    }
}
