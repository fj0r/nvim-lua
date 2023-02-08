return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function(plugin)
            vim.cmd'set background=dark|colorscheme gruvbox'
            --require'plugins.period-themes'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        config = function(plugin) require'plugins.lualine' end,
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function(plugin) require'plugins.colorizer' end
    },

    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = function(plugin) require'plugins.lush' end
    }
    --]=]
}
