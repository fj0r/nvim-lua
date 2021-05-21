require'lspconfig'.jsonls.setup {
}

require'lspconfig'.yamlls.setup {
    settings = {
        ['yaml.schemas'] = {
            [vim.g.config_root .. '/JSONSchema/compose-spec.json'] = {"/docker-compose.yml"} ,
            kubernetes =  { "/*" }
        },
        ['yaml.completion'] = true,
        ['yaml.format.singleQuote'] = true,
        ['yaml.hover'] = true,
        ['yaml.validate'] = true,
        ['yaml.trace.server'] = 'verbose', -- enum { "off", "messages", "verbose" }
    }
}
