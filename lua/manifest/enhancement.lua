local h = require('lazy_helper')
local m = require('setup').mod

return {
    -- find and replace
    {
        'nvim-pack/nvim-spectre',
        keys = {
            { '<leader>/', function() require("spectre").open() end, desc = 'Toggle Spectre' }
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        enabled = true,
        config = h.settings 'spectre',
    },
    {
        'mg979/vim-visual-multi',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = 'x' },
            { 'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign' },
        },
    },
    {
        'junegunn/rainbow_parentheses.vim',
        enabled = vim.g.nvim_level >= 2,
        config = h.settings 'rainbow'
    },
    {
        'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
        config = h.settings 'ultimate-autopair',
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        keys = {
            { 'gw', 'remove', desc = 'remove tailing whitespace' },
        },
        'johnfrankmorgan/whitespace.nvim',
        config = h.settings 'whitespace'
    },
    {
        'stevearc/resession.nvim',
        enabled = vim.g.nvim_level >= 2,
        config = h.settings 'ressession',
        opts = {},
    },
    {
        "chrisgrieser/nvim-early-retirement",
        enabled = vim.g.nvim_level >= 2,
        config = true,
        event = "VeryLazy",
    },
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle",
        event = { "InsertLeave", "TextChanged" },
        config = h.settings 'auto-save',
        -- opts = {
        -- },
    }
}
