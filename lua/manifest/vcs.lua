local apply_keymap = require('lazy_helper').apply_keymap
return {
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        -- version = 'release' -- To use the latest release
        config = function(plugin) require 'plugins.gitsigns' end
    },
    {
        'sindrets/diffview.nvim',
        keys = {
            { '<leader>gd', "<cmd>DiffviewOpen<cr>", desc = 'DiffviewOpen' },
            { '<leader>gf', "<cmd>DiffviewFileHistory %<cr>", desc = 'DiffviewFileHistory' },
            { '<leader>gh', "<cmd>DiffviewFileHistory<cr>", desc = 'DiffviewHistory' },
            { '<leader>gx', "<cmd>DiffviewClose<cr>", desc = 'DiffviewClose' },
        },
        config = function(plugin)
            require 'plugins.diffview'
            apply_keymap(plugin)
        end
    },
    {
        'TimUntersberger/neogit',
        keys = {
            { '<leader>gg', function() require 'neogit'.open({ kind = 'split' }) end, desc = 'neogit' },
        },
        config = function(plugin)
            --vim.opt.rtp:append(plugin.dir)
            require 'plugins.neogit'
            apply_keymap(plugin)
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
}
