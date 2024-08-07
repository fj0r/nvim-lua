local util = require 'lspconfig.util'
local wh = require 'utils'.which

local function get_typescript_server_path(root_dir)
    local global_ts = wh 'node' .. '/../../lib/node_modules/typescript/lib/tsserverlibrary.js'
    local found_ts = ''
    local function check_dir(path)
        found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
        if util.path.exists(found_ts) then
            return path
        end
    end
    if util.search_ancestors(root_dir, check_dir) then
        return found_ts
    else
        return global_ts
    end
end

--[[
require 'lspconfig'.volar.setup {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    on_new_config = function(new_config, new_root_dir)
        new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
    end,
}
--]]
