local h = require('lazy_helper')

return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = h.plugins 'flash',
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
                -- S for nvim-surround in "x"(visual)
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
                mode = { 'n', 'v' },
                'jump_to_line',
                desc = 'flash hint_lines'
            },
            {
                '<leader><leader>',
                mode = { 'n', 'v' },
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
        config = h.plugins 'lightspeed',
        enabled = false,
    },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        keys = {
            --[[ standalone
            {';', nil, desc = 'hop hint_words'},
            {',', nil, desc = 'hop hint_char1'},
            {'s', nil, desc = 'hop hint_char2'},
            {'<leader>;', nil, desc = 'hop hint_lines'},
            --]]
            { '<leader><leader>', 'hint_somewhere', desc = 'hop hint_words', mode = { 'n', 'v' } },
            { '<leader>;',        'hint_lines',     desc = 'hop hint_lines', mode = { 'n', 'v' } },
        },
        config = h.plugins 'hop',
        enabled = false,
    },
}
