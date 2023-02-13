return {
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    'tpope/vim-rsi',

    {
        "max397574/better-escape.nvim",
        enabled = os.getenv('VIM_DISABLE_DUAL_ESC') ~= '1',
        config = function() require 'plugins.better-escape' end
    },

    {
        "folke/which-key.nvim",
        config = function(plugin) require 'plugins.whichkey' end,
    },
}
