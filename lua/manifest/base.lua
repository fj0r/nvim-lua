return {
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    'tpope/vim-rsi',

    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup {
                mapping = { 'kj' }
            }
        end
    },

    {
        "folke/which-key.nvim",
        config = function(plugin) require 'plugins.whichkey' end,
    },
}
