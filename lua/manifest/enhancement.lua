local h = require('lazy_helper')

return {
    {
        'mg979/vim-visual-multi',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = 'x' },
            { 'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign' },
        },
    },
    {
        'junegunn/rainbow_parentheses.vim',
        enabled = vim.g.nvim_level >= 2,
        config = h.plugins 'rainbow'
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    },
    {
        'windwp/nvim-autopairs',
        config = h.plugins 'autopairs'
    },
    {
        "kylechui/nvim-surround",
        opts = {},
    },
    {
        keys = {
            { 'gw', 'remove', desc = 'remove tailing whitespace' },
        },
        'johnfrankmorgan/whitespace.nvim',
        config = h.plugins 'whitespace'
    },
    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        enabled = vim.g.nvim_level >= 2,
        config = h.plugins 'possession'
    },
    {
        'pocco81/auto-save.nvim',
        enabled = false,
        config = h.plugins 'auto-save'
    },
}
