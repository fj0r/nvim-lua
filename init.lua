vim.g.config_root = debug.getinfo(1, 'S').source:match('^@(.+)/.+$')
vim.g.data_root   = os.getenv('HOME') .. '/.nvim'
vim.opt.runtimepath:prepend(vim.g.config_root)

require 'env'
require 'shim'
require 'common'

-- 设置内置包管理器目录
local pack_root = vim.g.config_root .. '/pack/pafo'
local opt_dir = pack_root .. '/opt'
local start_dir = pack_root .. '/start'

-- 将 opt 目录中的插件添加到 runtimepath（按需加载）
local function add_opt_plugins()
    local handle = vim.loop.fs_scandir(opt_dir)
    if handle then
        while true do
            local name = vim.loop.fs_scandir_next(handle)
            if not name then break end
            local plugin_dir = opt_dir .. '/' .. name
            vim.opt.runtimepath:append(plugin_dir)
        end
    end
end

-- 将 start 目录中的插件添加到 runtimepath（启动加载）
local function add_start_plugins()
    local handle = vim.loop.fs_scandir(start_dir)
    if handle then
        while true do
            local name = vim.loop.fs_scandir_next(handle)
            if not name then break end
            local plugin_dir = start_dir .. '/' .. name
            vim.opt.runtimepath:append(plugin_dir)
        end
    end
end

-- 添加所有插件到 runtimepath
add_start_plugins()
add_opt_plugins()

-- 加载 package_helper 替代 lazy_helper
local pkg = require('package_helper')

-- 加载 manifest 目录中的插件配置
local function load_manifest(file)
    local ok, plugins = pcall(require, 'manifest.' .. file)
    if not ok then
        return
    end

    for _, plugin in ipairs(plugins or {}) do
        local plugin_name = plugin[1] or plugin.name
        if plugin_name then
            -- 处理 enabled 选项
            if plugin.enabled == false then
                goto continue
            end

            -- 处理 config 选项
            if plugin.config and type(plugin.config) == 'function' then
                if pkg.has_plugin(plugin_name) then
                    plugin.config(plugin)
                end
            end

            -- 处理 opts 选项
            if plugin.opts then
                local ok, module = pcall(require, plugin_name)
                if ok and module.setup then
                    module.setup(plugin.opts)
                end
            end

            -- 处理 event 选项（延迟加载）
            if plugin.event then
                pkg.on_event(plugin.event, function()
                    if plugin.config and type(plugin.config) == 'function' then
                        plugin.config(plugin)
                    end
                end)
            end
        end

        ::continue::
    end
end

-- 加载所有 manifest 文件
local manifest_files = {
    'base', 'component', 'dev', 'enhancement', 'experiment',
    'fixme', 'game', 'lang', 'motion', 'other', 'task', 'term',
    'theme', 'ui', 'vcs', 'ai'
}

for _, file in ipairs(manifest_files) do
    load_manifest(file)
end

-- 触发 VeryLazy 事件
pkg.fire_very_lazy()

-- 加载用户自定义配置
local user_config = os.getenv("HOME") .. '/.nvim.lua'
if vim.fn.empty(vim.fn.glob(user_config)) == 0 then
    vim.cmd('luafile ' .. user_config)
end
