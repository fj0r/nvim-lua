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

    opt = type(opt) == 'table' and opt or { fns = {} }
    for _, k in ipairs(plugin.keys) do
        local lo = k.desc and { silent = true, noremap = true, desc = k.desc } or o
        local mode = type(k.mode) == 'table' and k.mode or { k.mode or 'n' }
        for _, m in ipairs(mode) do
            vim.keymap.set(m, k[1], opt.fns[k[2]] or k[2], lo)
        end
    end
end

local wrap_config = function(dir)
    return function(file)
        return function(plugin)
            -- vim.opt.rtp:append(plugin.dir)
            -- debug: print(vim.inspect(plugin[1]))
            M.apply_keymap(plugin, require(dir .. '.' .. file))
        end
    end
end

M.settings = wrap_config('settings')
M.plugins = wrap_config('plugins')

return M
