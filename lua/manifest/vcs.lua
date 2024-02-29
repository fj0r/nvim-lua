local h = require('lazy_helper')

return {
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        enabled = vim.g.has_git and vim.g.nvim_level >= 2,
        config = h.plugins 'gitsigns',
    },
    {
        'sindrets/diffview.nvim',
        keys = {
            { '<leader>gd', "<cmd>DiffviewOpen<cr>",          desc = 'DiffviewOpen' },
            { '<leader>gf', "<cmd>DiffviewFileHistory %<cr>", desc = 'DiffviewFileHistory' },
            { '<leader>gh', "<cmd>DiffviewFileHistory<cr>",   desc = 'DiffviewHistory' },
            { '<leader>gx', "<cmd>DiffviewClose<cr>",         desc = 'DiffviewClose' },
        },
        opts = {},
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'NeogitOrg/neogit',
        keys = {
            { '<leader>gg', function() require 'neogit'.open({ kind = 'split' }) end, desc = 'neogit' },
        },
        config = h.plugins 'neogit',
        dependencies = { 'nvim-lua/plenary.nvim' },
        enabled = vim.g.nvim_level >= 2,
    },
}
