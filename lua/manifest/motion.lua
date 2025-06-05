local h = require('lazy_helper')
local m = require('setup').mod

return {
    {
        "folke/flash.nvim",
        enabled = false,
        event = "VeryLazy",
        config = h.settings 'flash',
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function() require("flash").jump() end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o" },
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
            {
                '<leader>;',
                mode = { 'n', 'x' },
                'jump_to_line',
                desc = 'flash hint_lines'
            },
            {
                '<leader><leader>',
                mode = { 'n', 'x' },
                'any_word',
                desc = 'flash hint_words'
            },
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
            { 's',                'char1',     desc = 'hop char1',      mode = { 'n', 'x' } },
            { '<leader><leader>', 'somewhere', desc = 'hop hint_words', mode = { 'n', 'x', 'o' } },
            { '<leader>;',        'lines',     desc = 'hop hint_lines', mode = { 'n', 'x', 'o' } },
        },
        config = h.settings 'hop',
    },
}
