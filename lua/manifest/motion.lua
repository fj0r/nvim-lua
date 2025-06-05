local h = require('lazy_helper')
local m = require('setup').mod

return {
    {
        "folke/flash.nvim",
        enabled = true,
        event = "VeryLazy",
        config = h.settings 'flash',
        ---@type Flash.Config
        opts = {},
        keys = {
            { "s",                mode = { "n", "x", "o" }, 'search' },
            { "S",                mode = { "n", "o" },      'treesitter' },
            { "r",                mode = "o",               'remote' },
            { "R",                mode = { "o", "x" },      'treesitter_search' },
            { "<c-s>",            mode = { "c" },           'toggle' },
            { '<leader>;',        mode = { 'n', 'x' },      'jump_to_line' },
            { '<leader><leader>', mode = { 'n', 'x' },      'any_word' },
        },
    },
    {
        'chaoren/vim-wordmotion',
        enabled = false,
        config = function()
            vim.g.wordmotion_uppercase_spaces = { '/', '.', '{', '}', '(', ')' }
        end
    },
    'wellle/targets.vim',
    {
        'ggandor/lightspeed.nvim',
        keys = {
            { 's', '<Plug>Lightspeed_omni_s',  desc = 'Lightspeed_omni_s' },
            { 'S', '<Plug>Lightspeed_omni_gs', desc = 'Lightspeed_omni_gs' },
        },
        config = h.settings 'lightspeed',
        enabled = false,
    },
    {
        'ggandor/leap.nvim',
        keys = {
            { m('s', true), 'bi', mode = { 'n', 'x', 'o' } },
        },
        config = h.settings 'leap',
        enabled = false,
    },
    {
        'smoka7/hop.nvim',
        keys = {
            --{ 'f', 'char1',     desc = 'hop char1',      mode = { 'n', 'x' } },
            { '<leader><leader>', 'somewhere', desc = 'hop hint_words', mode = { 'n', 'x', 'o' } },
            { 'F',                'lines',     desc = 'hop hint_lines', mode = { 'n', 'x', 'o' } },
        },
        enabled = false,
        config = h.settings 'hop',
    },
}
