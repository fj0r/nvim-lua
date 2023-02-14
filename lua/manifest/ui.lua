return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function(plugin)
            vim.cmd 'set background=dark|colorscheme gruvbox'
            --require'plugins.period-themes'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        config = function(plugin) require 'plugins.lualine' end,
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function(plugin) require 'plugins.colorizer' end
    },

    {
        'stevearc/dressing.nvim',
        config = function(plugin) require 'plugins.dressing' end
    },

    {
        'notomo/cmdbuf.nvim',
        enabled = false,
        config = function(plugin) require 'plugins.cmdbuf' end,
    },

    {
        'kevinhwang91/nvim-hlslens',
        config = function(plugin) require 'hlslens'.setup() end
    },
    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = function(plugin) require'plugins.lush' end
    }
    --]=]
}
