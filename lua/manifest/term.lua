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
        enabled = vim.g.nvim_level >= 2,
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
