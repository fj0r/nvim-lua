vim.g.config_root = debug.getinfo(1, 'S').source:match('^@(.+)/.+$')
vim.g.data_root   = os.getenv('HOME') .. '/.nvim'
vim.g.has_git     = pcall(vim.fn.systemlist, { 'git', '--version' })
vim.g.nvim_preset = vim.fn.exists('$NVIM_PRESET') == 1 and 'ext'
                 or vim.g.vscode and 'embed'
                 or vim.g.started_by_firenvim and 'embed'
                 or 'core'
vim.g.nvim_level  = ({ embed = 1, core = 2, ext = 3 })[vim.g.nvim_preset]
vim.opt.runtimepath:prepend(vim.g.config_root)

require 'settings.common'

local lazyhome = vim.g.config_root .. '/lazy'
local lazypath = lazyhome .. '/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('manifest', {
    root = lazyhome .. '/packages',
    readme = {
        root = lazyhome .. '/readme',
    }
})

local user_config = os.getenv("HOME") .. '/.nvim.lua'
if vim.fn.empty(vim.fn.glob(user_config)) == 0 then
    vim.cmd('luafile ' .. user_config)
end
