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
            { "s",     mode = { "n", "x", "o" }, 'search' },
            { "S",     mode = { "n", "o" },      'treesitter' },
            { "r",     mode = { "o" },           'remote' },
            { "R",     mode = { "o", "x" },      'treesitter_search' },
            { "<c-s>", mode = { "c" },           'toggle' },
            -- { '<leader>;',        mode = { 'n', 'x' },      'jump_to_line' },
            -- { '<leader><leader>', mode = { 'n', 'x' },      'any_word' },
        },
    },
    {
        'smoka7/hop.nvim',
        keys = {
            -- { 'f', 'char1',     desc = 'hop char1',      mode = { 'n', 'x' } },
            { '<leader><leader>', 'somewhere', desc = 'hop hint_words', mode = { 'n', 'x', 'o' } },
            { '<leader>;',        'lines',     desc = 'hop hint_lines', mode = { 'n', 'x', 'o' } },
        },
        enabled = true,
        config = h.settings 'hop',
    },
    {
        'chaoren/vim-wordmotion',
        enabled = false,
        config = function()
            vim.g.wordmotion_uppercase_spaces = { '/', '.', '{', '}', '(', ')' }
        end
    },
    'wellle/targets.vim',
}
