local h = require('lazy_helper')

return {
    {
        'nvim-lualine/lualine.nvim',
        config = h.plugins 'lualine',
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = h.plugins 'colorizer'
    },

    {
        'stevearc/dressing.nvim',
        config = h.plugins 'dressing'
    },

    {
        'notomo/cmdbuf.nvim',
        enabled = false,
        config = h.plugins 'cmdbuf',
    },

    {
        'kevinhwang91/nvim-hlslens',
        opts = {}
    },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = 80,
            custom_colorcolumn = {
                python     = 100,
                go         = 120,
                typescript = 120,
                rust       = 150,
                haskell    = 150,
                scala      = 200,
                java       = 200,
            },
            disabled_filetypes = {
                "help", "text", "markdown",
                unpack(vim.g.plugin_filetypes),
            }
        }
    },
    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = function(plugin) require'plugins.lush' end
    }
    --]=]
}
