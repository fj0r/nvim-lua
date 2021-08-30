local config = require'syncJSONSchema':config()

require'lspconfig'.jsonls.setup {
    settings = {
        ['json.colorDecorators.enable'] = true,
        ['json.format.enable']          = true,
        ['json.schemaDownload.enable']  = true,
        ['json.trace.server']           = 'verbose'
    }
}

require'lspconfig'.yamlls.setup {
    settings = {
        yaml = { schemas = config },
        ['yaml.completion']         = true,
        ['yaml.schemaStore.enable'] = true,
        ['yaml.format.singleQuote'] = true,
        ['yaml.hover']              = true,
        ['yaml.validate']           = true,
        ['yaml.trace.server']       = 'verbose', -- enum { "off", "messages", "verbose" }
    }
}
