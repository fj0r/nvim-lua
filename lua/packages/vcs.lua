return {
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        -- version = 'release' -- To use the latest release
        config = function(plugin) require'extensions.gitsigns' end
    },
    {
        'sindrets/diffview.nvim',
        keys = {
            {'<leader>gd', nil, desc = 'diffview open'},
            {'<leader>gf', nil, desc = 'diffview file history'},
            {'<leader>gh', nil, desc = 'diffview history'},
        },
        config = function(plugin) require'extensions.diffview' end
    },
    {
        'TimUntersberger/neogit',
        keys = {{'<leader>gg', nil, desc = 'neogit'}},
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir)
            require'extensions.neogit'
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
}
