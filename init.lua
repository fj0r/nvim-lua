vim.g.config_root = debug.getinfo(1, 'S').source:match('^@(.+)/.+$')
vim.g.data_root   = os.getenv('HOME') .. '/.nvim'
vim.opt.runtimepath:prepend(vim.g.config_root)

require 'env'
require 'shim'
require 'common'

local lazyhome = vim.g.config_root .. '/lazy'
local lazypath = lazyhome .. '/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
    },
    change_detection = { enabled = false }
})

local user_config = os.getenv("HOME") .. '/.nvim.lua'
if vim.fn.empty(vim.fn.glob(user_config)) == 0 then
    vim.cmd('luafile ' .. user_config)
end
