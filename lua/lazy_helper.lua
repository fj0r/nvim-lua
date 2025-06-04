local M = {}

local plugins = {}
for _, i in ipairs(require("lazy").plugins()) do
    plugins[i.name] = true
end

function M.has_plugin(p)
    return plugins[p]
end

function M.all_plugin()
    return plugins
end

local o = { silent = true, noremap = true }
function M.apply_keymap(plugin, opt)
    if not plugin.keys then
        return
    end

    if not type(opt) == 'table' then
        return
    end

    for _, k in ipairs(plugin.keys) do
        local desc = k.desc
        local lo = desc and { silent = true, noremap = true, desc = desc } or o
        local mode = type(k.mode) == 'table' and k.mode or { k.mode or 'n' }
        for _, m in ipairs(mode) do
            vim.keymap.set(m, k[1], opt[k[2]] or k[2], lo)
        end
    end
end

function M.setup(plugin, opt)
    if not (type(opt) == 'table' and opt.setup) then return end
    opt.setup(plugin, { apply_keymap = M.apply_keymap })
end

local wrap_config = function(dir)
    return function(file)
        return function(plugin)
            -- vim.opt.rtp:append(plugin.dir)
            -- debug: print(vim.inspect(plugin[1]))
            local opt = require(dir .. '.' .. file)
            M.setup(plugin, opt)
        end
    end
end

M.settings = wrap_config('settings')
M.plugins = wrap_config('settings')

return M
