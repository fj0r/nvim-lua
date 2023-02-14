return {
    'mg979/vim-visual-multi',

    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = 'x' },
            { 'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign' },
        },
    },
    {
        'Chiel92/vim-autoformat',
        keys = {
            { '[f', '<cmd>Autoformat<cr>', desc = 'Autoformat' },
        },
    },
    {
        'junegunn/rainbow_parentheses.vim',
        config = function(plugin) require 'plugins.rainbow' end
    },
    {
        'numToStr/Comment.nvim',
        config = function(plugin) require 'Comment'.setup() end
    },
    {
        'windwp/nvim-autopairs',
        config = function(plugin) require 'plugins.autopairs' end
    },
    {
        "kylechui/nvim-surround",
        config = function(plugin) require 'plugins.surround' end
    },
    {
        'johnfrankmorgan/whitespace.nvim',
        config = function (plugin) require 'plugins.whitespace' end
    },
    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(plugin) require 'plugins.possession' end
    },
}
