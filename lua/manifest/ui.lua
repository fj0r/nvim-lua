local h = require('lazy_helper')

return {
    {
        'nvim-lualine/lualine.nvim',
        config = h.plugins 'lualine',
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = h.plugins 'colorizer',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'stevearc/dressing.nvim',
        config = h.plugins 'dressing',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'notomo/cmdbuf.nvim',
        config = h.plugins 'cmdbuf',
        enabled = false,
    },

    {
        'kevinhwang91/nvim-hlslens',
        opts = {},
        enabled = false and vim.g.nvim_level >= 2,
    },
}
