return {
    {
        'fj0r/nvim-taberm',
        config = function(plugin) require'taberm'.setup{} end,
    },
    --[=[
    {
        'akinsho/nvim-toggleterm.lua',
        keys = {
            {'<leader>xt', nil, desc = 'toggleterm'},
            {'<leader>xy', nil, desc = 'vtoggleterm'},
            {'<leader>xp', nil, desc = 'toggleterm ipython'},
        },
        version = 'v2.*',
        config = function(plugin) require'addons.toggleterm' end,
    },
    --]=]
    {
        'stevearc/overseer.nvim',
        lazy = true,
        keys = {
            {'<leader>ot', nil, desc = 'overseer toggle'},
            {'<leader>oo', nil, desc = 'overseer open'},
            {'<leader>or', nil, desc = 'overseer run'},
        },
        cmd = {
            'OverseerRun',
            'OverseerOpen',
            'OverseerBuild',
            'OverseerToggle',
            'OverseerRunCmd',
            'OverseerQuickAction',
            'OverseerTaskAction'
        },
        config = function(plugin) require'addons.overseer' end,
    },

    --[=[
    {
        'pianocomposer321/yabs.nvim',
        keys = {{'<leader>j', nil, desc = 'yabs'}},
        version = "main",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function(plugin) require'addons.yabs' end,
    },
    --]=]
}
