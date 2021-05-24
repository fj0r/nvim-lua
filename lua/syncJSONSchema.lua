local M = {}

local s = vim.g.config_root .. '/JSONSchema'

M.enabled = {
    ['docker-compose.yml']   = 'docker-compose',
    ['drone.json']           = 'drone',
    ['gitlab-ci']            = 'gitlab-ci',
    ['hydra.yml']            = 'hydra',
    ['JSON-API']             = 'json-api',
    ['JSON Schema Draft 7' ] = 'jsonSCHEMA',
    ['Jenkins X Pipelines']  = 'jx',
    ['kratos.yml']           = 'kratos',
    ['kustomization.yaml']   = 'kustomization',
    ['openapi.json']         = 'openapi',
    ['Traefik v2']           = 'traefik',
}

M.fetchJson = function (file, url)
    local cmd = {'curl -sSL', url, '>', s..'/'..file..'.json' }
    local out = io.popen(table.concat(cmd, ' '))
    out:close()
end

M.loadCatalog = function ()
    local path = s..'/catalog.json'
    if vim.fn.filereadable(path) ~= 0 then
        local c = vim.fn.readfile(path)
        return vim.fn.json_decode(c)['schemas']
    end
end

M.syncSchemas = function (self)
    self.fetchJson('catalog', 'https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/api/json/catalog.json')
    for _, v in pairs(self.loadCatalog()) do
        local name = self.enabled[v.name]
        if name then
            self.fetchJson(name, v.url)
        end
    end
end

M.config = function (self)
    local c = {}
    for _, v in pairs(self.loadCatalog()) do
        local name = self.enabled[v.name]
        if name then
            c[s..'/'..name..'.json'] = v.fileMatch
        end
    end
    --[[
    sudo sed -i "s/\(exports.KUBERNETES_SCHEMA_URL = \)\(.*\)/\1process.env['KUBERNETES_SCHEMA_URL'] || \2/" \
        $(dirname $(which yaml-language-server))/../lib/node_modules/yaml-language-server/out/server/src/languageservice/utils/schemaUrls.js
    --]]
    c.kubernetes = { '/*' }
    return c
end

--M:syncSchemas()

return M
--vim.api.nvim_set_var('VimspectorConfigurationSets', M:get_lang_list())
--vim.api.nvim_exec([[
--function! VimspectorConfigurationSetCompletion(ArgLead, CmdLine, CursorPos)
--    return filter(g:VimspectorConfigurationSets, 'v:val =~ "^'. a:ArgLead .'"')
--endfunction
--
--command! -complete=customlist,VimspectorConfigurationSetCompletion -nargs=1 AddVimspectorConfiguration :lua MakeVimspectorConfiguration(<f-args>)
--]], false)

