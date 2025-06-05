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

function M.apply_keymap(plugin, km, opt)
    if not plugin.keys then
        return
    end

    if not type(km) == 'table' then
        return
    end

    local opt = type(opt) == 'table' and opt or {}

    for _, k in ipairs(plugin.keys) do
        local key = k[1]
        local fn = k[2]
        local o = { silent = true, noremap = true }
        if opt.buf then
            o.buffer = opt.buf
        end
        if opt.desc then
            if opt.desc and type(fn) == 'string' then
                o.desc = opt.desc(fn, k.desc)
            else
                o.desc = k.desc
            end
        end
        local mode = type(k.mode) == 'table' and k.mode or 'n'
        vim.keymap.set(mode, key, km[fn] or fn, o)
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

return M
