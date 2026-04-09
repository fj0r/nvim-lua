-- lazy_helper.lua
-- 兼容层：将 lazy.nvim API 调用重定向到 package_helper
-- 用于保持 manifest 目录中的插件配置不变

local M = {}

-- 委托到 package_helper
local pkg = require('package_helper')

-- 兼容 lazy.plugins() 的返回值格式
function M.plugins()
    return pkg.plugins()
end

function M.has_plugin(p)
    return pkg.has_plugin(p)
end

function M.all_plugin()
    return pkg.all_plugin()
end

function M.apply_keymap(kdecl, kdef, opt)
    if not kdecl then
        return
    end

    if not type(kdef) == 'table' then
        return
    end

    local opt = type(opt) == 'table' and opt or {}

    for _, k in ipairs(kdecl) do
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
        local mode = type(k.mode) == 'table' and k.mode or { 'n' }
        local d = kdef[fn] or fn
        vim.keymap.set(mode, key, d, o)
    end
end

function M.setup(plugin, opt)
    if not (type(opt) == 'table' and opt.setup) then return end
    opt.setup(plugin, { apply_keymap = M.apply_keymap })
end

-- 包装配置加载函数，保持与 lazy 相同的 API
local wrap_config = function(dir)
    return function(file)
        return function(plugin)
            local opt = require(dir .. '.' .. file)
            M.setup(plugin, opt)
        end
    end
end

M.settings = wrap_config('settings')

-- 导出 package_helper 的其他功能以便需要时使用
M.get_plugin_dir = function(name)
    return pkg.get_plugin_dir(name)
end

M.load = function(name)
    return pkg.load(name)
end

M.is_loaded = function(name)
    return pkg.is_loaded(name)
end

return M
