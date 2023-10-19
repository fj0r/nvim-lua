local h = require('lazy_helper')

return {
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'tpope/vim-rsi',
    },
    {
        "max397574/better-escape.nvim",
        enabled = os.getenv('NVIM_ENABLE_DUAL_ESC') == '1',
        config = h.plugins 'better-escape'
    },
    {
        "folke/which-key.nvim",
        config = h.plugins 'whichkey',
    },
}
