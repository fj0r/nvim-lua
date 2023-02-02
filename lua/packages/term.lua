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
        config = function(plugin) require'extensions.toggleterm' end,
    },
    --]=]
    {
        'stevearc/overseer.nvim',
        lazy = true,
        keys = {
            {'<leader>oo', nil, desc = 'overseer toggle'},
            {'<leader>or', nil, desc = 'overseer run'},
            {'<leader>ob', nil, desc = 'overseer build'},
            {'<leader>ot', nil, desc = 'overseer task action'},
            {'<leader>oq', nil, desc = 'overseer quick action'},
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
        config = function(plugin) require'extensions.overseer' end,
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
        config = function(plugin) require'extensions.yabs' end,
    },
    --]=]
}
