vim.g.config_root  = debug.getinfo(1,'S').source:match('^@(.+)/.+$')
vim.g.data_root    = os.getenv('HOME') .. '/.nvim'
vim.g.nvim_preset  = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'
vim.g.has_git      = pcall(vim.fn.systemlist, { 'git', '--version'})
vim.opt.runtimepath:prepend(vim.g.config_root)

require 'settings'

local lazypath = vim.g.config_root .. "/lazy/lazy.nvim"
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
    root = vim.g.config_root .. "/lazy/packages",
    readme = {
        root = vim.g.config_root .. "/lazy/readme",
    }
})

local user_config = os.getenv("HOME") .. '/.nvim.lua'
if vim.fn.empty(vim.fn.glob(user_config)) == 0 then
    vim.cmd('luafile '..user_config)
end
