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
    'tpope/vim-commentary',
    {
        'windwp/nvim-autopairs',
        config = function(plugin) require 'plugins.autopairs' end
    },
    {
        'simnalamburt/vim-mundo',
        keys = { { '<leader>u', '<cmd>MundoToggle<CR>', desc = 'mundo' } },
    },
    {
        'tversteeg/registers.nvim',
        config = function(plugin) require 'registers'.setup() end
    },

    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(plugin) require 'plugins.possession' end
    },
}
