local h = require('lazy_helper')

return {
    {
        'tim-harding/neophyte',
        tag = '0.2.5',
        event = 'VeryLazy',
        config = h.settings 'neophyte',
        enabled = false
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = h.settings 'colorizer',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'kevinhwang91/nvim-hlslens',
        opts = {},
        enabled = false and vim.g.nvim_level >= 2,
    },
}
