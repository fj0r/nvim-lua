-- package_helper.lua
-- 模拟 lazy.nvim 的行为，用于 Neovim 内置包管理器
-- 支持 manifest 目录中的插件配置格式

local M = {}

-- 缓存已加载的插件信息
local loaded_plugins = {}
local plugin_configs = {}

-- 初始化插件列表
local function init_plugins()
    if loaded_plugins.name then
        return
    end

    loaded_plugins = {
        names = {},
        by_name = {}
    }

    -- 扫描 pack 目录中的插件
    local pack_root = vim.g.config_root .. '/pack/pafo'
    local load_types = { 'start', 'opt' }

    for _, load_type in ipairs(load_types) do
        local dir = pack_root .. '/' .. load_type
        local handle = vim.loop.fs_scandir(dir)
        if handle then
            while true do
                local name = vim.loop.fs_scandir_next(handle)
                if not name then
                    break
                end
                local plugin_info = {
                    name = name,
                    dir = dir .. '/' .. name,
                    loaded = load_type == 'start'
                }
                loaded_plugins.names[#loaded_plugins.names + 1] = plugin_info
                loaded_plugins.by_name[name] = plugin_info
            end
        end
    end
end

-- 获取所有插件列表，模拟 lazy.plugins()
function M.plugins()
    init_plugins()
    return loaded_plugins.names
end

-- 检查插件是否存在
function M.has_plugin(p)
    init_plugins()
    return loaded_plugins.by_name[p] ~= nil
end

-- 获取所有插件名称表
function M.all_plugin()
    init_plugins()
    local names = {}
    for _, plugin in ipairs(loaded_plugins.names) do
        names[plugin.name] = true
    end
    return names
end

-- 应用按键映射，模拟 lazy 的 keymap 配置
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

-- 执行插件 setup 函数
function M.setup(plugin, opt)
    if not (type(opt) == 'table' and opt.setup) then
        return
    end
    opt.setup(plugin, { apply_keymap = M.apply_keymap })
end

-- 包装配置加载函数
local wrap_config = function(dir)
    return function(file)
        return function(plugin)
            -- 延迟加载配置
            local config_module = dir .. '.' .. file
            local opt = require(config_module)
            M.setup(plugin, opt)
        end
    end
end

-- 模拟 lazy 的配置加载方式
M.settings = wrap_config('settings')

-- 延迟加载函数，用于模拟 event 触发
function M.on_event(event_name, callback)
    local augroup = vim.api.nvim_create_augroup('PackageHelperLazyLoad', { clear = false })
    vim.api.nvim_create_autocmd('User', {
        pattern = event_name,
        group = augroup,
        callback = callback
    })
end

-- 处理 VeryLazy 事件
function M.on_very_lazy(callback)
    vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = callback
    })
end

-- 注册插件配置
function M.register_config(plugin_name, config_fn)
    plugin_configs[plugin_name] = config_fn
end

-- 加载插件配置
function M.load_config(plugin_name)
    if plugin_configs[plugin_name] then
        local plugin = loaded_plugins.by_name[plugin_name]
        if plugin then
            plugin_configs[plugin_name](plugin)
            return true
        end
    end
    return false
end

-- 获取插件目录
function M.get_plugin_dir(plugin_name)
    init_plugins()
    local plugin = loaded_plugins.by_name[plugin_name]
    if plugin then
        return plugin.dir
    end
    return nil
end

-- 模拟 lazy 的 opts 配置处理
function M.setup_opts(plugin_name, opts)
    local ok, module = pcall(require, plugin_name)
    if ok then
        if module.setup then
            module.setup(opts)
        end
    end
end

-- 检查插件是否已加载
function M.is_loaded(plugin_name)
    init_plugins()
    local plugin = loaded_plugins.by_name[plugin_name]
    if plugin then
        -- 检查模块是否已加载
        return package.loaded[plugin_name] ~= nil
    end
    return false
end

-- 手动加载插件
function M.load(plugin_name)
    local plugin = loaded_plugins.by_name[plugin_name]
    if plugin then
        -- 将 opt 目录的插件添加到 runtimepath
        if not plugin.loaded then
            vim.opt.runtimepath:append(plugin.dir)
            plugin.loaded = true
        end
        -- 加载配置
        M.load_config(plugin_name)
        return true
    end
    return false
end

-- 触发 VeryLazy 事件（在启动完成时调用）
function M.fire_very_lazy()
    vim.schedule(function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' })
    end)
end

return M