local h = require('lazy_helper')

return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            vim.cmd 'set background=dark|colorscheme gruvbox'
            --require'plugins.period-themes'
        end
    },

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
