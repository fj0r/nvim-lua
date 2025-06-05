local h = require('lazy_helper')
local m = require('setup').mod

return {
    -- find and replace
    {
        'nvim-pack/nvim-spectre',
        keys = {
            { '<leader>S', function() require("spectre").open() end, desc = 'Toggle Spectre' }
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
        'numToStr/Comment.nvim',
        opts = {}
    },
    {
        'windwp/nvim-autopairs',
        config = h.settings 'autopairs',
    },
    {
        "kylechui/nvim-surround",
        opts = {
            keymaps = {
                --visual = m('s', true)
            }
        },
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
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        enabled = false,
        config = h.settings 'possession'
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
