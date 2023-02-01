return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function(plugin)
            vim.cmd'set background=dark|colorscheme gruvbox'
            --require'extensions.period-themes'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        config = function(plugin) require'extensions.lualine' end,
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function(plugin) require'extensions.colorizer' end
    },

    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = function(plugin) require'extensions.lush' end
    }
    --]=]
}
