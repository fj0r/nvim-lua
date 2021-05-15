require 'utils'
require 'setting.base'
require 'setting.keymap'
require 'setting.files'
require 'setting.completion'

local nvim = require 'nvim'
local themes = {
    'atelier-sulphurpool',
    'atlas',
    'black-metal-gorgoroth',
    'classic-dark',
    'default-dark',
    'gruvbox-dark-hard',
    'gruvbox-light-medium',
    'horizon-dark',
    'mocha',
}

math.randomseed(os.time())
local random_theme = themes[math.ceil(#themes * math.random())]

_G.BASE16_THEME = nvim.env.NVIM_THEME or 'gruvbox-dark-hard' or random_theme

local base16 = require 'base16'
base16(base16.themes[_G.BASE16_THEME], true)
