vim.g.json_schemas = require('schemastore').json.schemas {
    select = {
        'VSCode Code Snippets',
        'cspell',
        'Deno',
        'dockerd.json',
    },
    replace = {
        ['package.json'] = {
            description = 'package.json overriden',
            fileMatch = { 'package.json' },
            name = 'package.json',
            url = 'https://example.com/package.json',
        },
    }
}
require'lspconfig'.jsonls.setup {
    settings = {
        json = {
            schemas = vim.g.json_schemas,
            validate = { enable = true },
            colorDecorators = { enable = true },
            format = { enable = true },
            schemaDownload = { enable = true },
            trace = { server = 'verbose' },
        },
    }
}

local yaml_json_schemas = require('schemastore').json.schemas {
    select = {
        'Helm Chart.yaml',
        'GitHub Action',
        'GitHub Workflow',
        'gitlab-ci',
    }
}
local remote_schemas = {}
vim.tbl_map(function(schema) remote_schemas[schema.url] = schema.fileMatch end, yaml_json_schemas)
local local_schemas = require'syncJSONSchema':config()
vim.g.yaml_schemas = vim.tbl_extend('force', remote_schemas, local_schemas)
require'lspconfig'.yamlls.setup {
    settings = {
        yaml = {
            completion = true,
            schemaStore = { enable = true },
            format = { singleQuote = true },
            hover = true,
            validate = true,
            trace = { server = 'verbose' },
            schemas = vim.g.yaml_schemas
        }
    }
}
