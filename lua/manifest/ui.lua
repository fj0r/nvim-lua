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
        'nvim-lualine/lualine.nvim',
        config = h.settings 'lualine',
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'folke/noice.nvim',
        enabled = vim.g.nvim_level >= 2,
        config = h.settings 'noice',
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = h.settings 'colorizer',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'rcarriga/nvim-notify',
    },
    {
        'MunifTanjim/nui.nvim',
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = h.settings 'noice',
        enabled = false,
    },
    {
        'stevearc/dressing.nvim',
        config = h.settings 'dressing',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'kevinhwang91/nvim-hlslens',
        opts = {},
        enabled = false and vim.g.nvim_level >= 2,
    },
}
