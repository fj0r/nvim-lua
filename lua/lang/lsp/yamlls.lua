local schema_path = 'file://' .. vim.g.config_root .. '/JSONSchema'

require'lspconfig'.jsonls.setup {
    settings = {
        ['json.colorDecorators.enable'] = true,
        ['json.format.enable'] = true,
        ['json.schemaDownload.enable'] = true,
        ['json.trace.server'] = 'verbose'
    }
}

require'lspconfig'.yamlls.setup {
    settings = {
        ['yaml.schemas'] = {
            [schema_path..'/mutagen.json'] = {"/mutagen.yml"} ,
            kubernetes =  { "/*" }
        },
        ['yaml.completion'] = true,
        ['yaml.format.singleQuote'] = true,
        ['yaml.hover'] = true,
        ['yaml.validate'] = true,
        ['yaml.trace.server'] = 'verbose', -- enum { "off", "messages", "verbose" }
    }
}
