vim.g.local_schemas_store = vim.g.config_root .. '/schemas'

local sync = function(url)
    local uri = vim.fn.substitute(url, 'https\\?://', '', '')
    local name = vim.fn.substitute(uri, '[/#$]', ':', 'g')
    local file = vim.g.local_schemas_store .. '/' .. name
    if vim.fn.empty(vim.fn.glob(file)) == 1 then
        vim.o.cmdheight = 1
        print('sync' .. ' [' .. url .. ']' .. file)
        local cmd = { 'curl -sSL', url, '>', file }
        local out = io.popen(table.concat(cmd, ' '))
        if out == nil then return end
        out:close()
        vim.o.cmdheight = 0
    end
    return 'file://' .. file
end

local json_origin = require('schemastore').json.schemas {
    select = {
        'appsettings.json',
        'AsyncAPI',
        'Avro Avsc',
        'bucklescript',
        'Cargo Manifest',
        'Cargo Make',
        'Chrome Extension',
        'component.json',
        'dockerd.json',
        '.esmrc.json',
        'GitHub Workflow Template Properties',
        'httparchive',
        'jsdoc',
        'JSON-API',
        'JSON Schema Draft 4',
        'JSON Schema Draft 7',
        'JSON Schema Draft 2020-12',
        'JSONPatch',
        'mimetypes.json',
        'openapi.json',
        'openrpc.json',
        'package.json',
        'prometheus.rules.json',
        'Solidarity',
        'Source Maps v3',
        'swcrc',
        'tsconfig.json',
        'tsd.json',
        'tsdrc.json',
        'tslint.json',
        'typedoc.json',
        'typings.json',
        'typingsrc.json',
        'vim-addon-info',
        'V2Ray',
        'VSCode Code Snippets',
    },
    --[[
        replace = {
            ['package.json'] = {
                description = 'package.json overriden',
                fileMatch = { 'package.json' },
                name = 'package.json',
                url = ''
            },
        }
        --]]
}
local json_schemas = {}
local replace_url = function(schema)
    if schema.url then
        schema.url = sync(schema.url)
        table.insert(json_schemas, schema)
    end
end
vim.tbl_map(replace_url, json_origin)
vim.g.json_schemas = json_schemas

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('jsonls', {
    capabilities = capabilities,
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
})
vim.lsp.enable('jsonls')

local yaml_origin = require('schemastore').json.schemas {
    select = {
        'Ansible Argument Specs',
        'Ansible Collection Galaxy',
        'Ansible Execution Environment',
        'Ansible Inventory',
        'Ansible Meta',
        'Ansible Meta Runtime',
        'Ansible Navigator Configuration',
        'Ansible Playbook',
        'Ansible Requirements',
        'Ansible Tasks File',
        'Ansible Vars File',
        'Ansible-lint Configuration',
        'Argo Events',
        'Argo Workflows',
        'AsyncAPI',
        'docker-compose.yml',
        'GitHub Action',
        'GitHub Workflow',
        'gitlab-ci',
        'JSON-API',
        'JSON Schema Draft 4',
        'JSON Schema Draft 7',
        'JSON Schema Draft 2020-12',
        'kustomization.yaml',
        'Helm Chart.yaml',
        'openapi.json',
        'openrpc.json',
        'prometheus.json',
        'Traefik v2',
    }
}
local yaml_schemas = {
    -- https://github.com/yannh/kubernetes-json-schema/tree/master/v1.29.2-local
    ['file://' .. (vim.g.local_schemas_store .. '/kubernetes/all.json' or 'kubernetes')] = { '/*.yaml' }
}
vim.tbl_map(function(schema) yaml_schemas[sync(schema.url)] = schema.fileMatch end, yaml_origin)
-- # yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>

vim.g.yaml_schemas = yaml_schemas
vim.lsp.config('yamlls', {
    settings = {
        yaml = {
            completion = true,
            --schemaStore = { enable = false },
            format = { singleQuote = true },
            hover = true,
            validate = true,
            trace = { server = 'verbose' },
            schemas = vim.g.yaml_schemas
        }
    }
})
vim.lsp.enable('yamlls')
