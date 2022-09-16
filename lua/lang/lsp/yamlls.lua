require'lspconfig'.jsonls.setup {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas {
                ignore = {
                    '.eslintrc',
                },
                replace = {
                    ['package.json'] = {
                        description = 'package.json overriden',
                        fileMatch = { 'package.json' },
                        name = 'package.json',
                        url = 'https://example.com/package.json',
                    },
                }
            },
            validate = { enable = true },
            colorDecorators = { enable = true },
            format = { enable = true },
            schemaDownload = { enable = true },
            trace = { server = 'verbose' },
        },
    }
}

local config = require'syncJSONSchema':config()
require'lspconfig'.yamlls.setup {
    settings = {
        yaml = {
            completion = true,
            schemaStore = { enable = true },
            format = { singleQuote = true },
            hover = true,
            validate = true,
            trace = { server = 'verbose' },
            schemas = config
            --[[
            schemas = require('schemastore').json.schemas {
                select = {
                    'docker-compose',
                    'gitlab-ci',
                    'kustomization',
                    'openapi',
                    'traefik',
                }
            }
            --]]
        }
    }
}
