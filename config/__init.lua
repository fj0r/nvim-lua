require 'utils'
require 'setting.base'
require 'setting.keymap'
require 'setting.files'
require 'setting.completion'

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


