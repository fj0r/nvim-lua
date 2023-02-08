return {
    {
        'stevearc/overseer.nvim',
        lazy = true,
        keys = {
            {'<leader>oo', nil, desc = 'overseer toggle'},
            {'<C-t>'     , nil, desc = 'overseer toggle'},
            {'<leader>or', nil, desc = 'overseer run'},
            {'<leader>j', nil, desc = 'overseer run'},
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
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function(plugin) require'plugins.overseer' end,
    },
}
