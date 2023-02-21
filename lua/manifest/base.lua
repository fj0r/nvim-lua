local h = require('lazy_helper')

return {
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    'tpope/vim-rsi',

    {
        "max397574/better-escape.nvim",
        enabled = os.getenv('VIM_DISABLE_DUAL_ESC') ~= '1',
        config = h.plugins 'better-escape'
    },

    {
        "folke/which-key.nvim",
        config = h.plugins 'whichkey',
    },
}
