return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function(plugin)
            vim.cmd'set background=dark|colorscheme gruvbox'
            --require'addons.period-themes'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        config = function(plugin) require'addons.lualine' end,
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function(plugin) require'addons.colorizer' end
    },

    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = function(plugin) require'addons.lush' end
    }
    --]=]
}
