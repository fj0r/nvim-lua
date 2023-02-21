return {
    {
        'fj0r/nvim-taberm',
        keys = {
            { '<C-x>', nil, desc = 'taberm' },
        },
        opts = {
            keymap = {
                toggle = '<C-x>'
            }
        },
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
        config = function(plugin) require'plugins.toggleterm' end,
    },
    --]=]
}
