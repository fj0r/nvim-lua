local config = require'syncJSONSchema':config()

vim.cmd [[autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>]]

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
