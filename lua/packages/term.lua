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
}