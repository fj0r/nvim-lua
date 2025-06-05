local h = require('lazy_helper')

return {
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'tpope/vim-rsi',
        enabled = false
    },
    {
        "max397574/better-escape.nvim",
        enabled = os.getenv('NVIM_ENABLE_DUAL_ESC') == '1',
        config = h.settings 'better-escape'
    },
    {
        "folke/which-key.nvim",
        enabled = false,
        config = h.settings 'whichkey',
    },
}
