return {
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        keys = {
            {'s', nil, desc = 'hop hint_words'},
            {'<leader>s', nil, desc = 'hop hint_char1'},
            {'S', nil, desc = 'hop hint_lines'},
        },
        config = function(plugin) require'extensions.hop' end,
    },
    {
        'chaoren/vim-wordmotion',
        enabled = false,
        config = function ()
            vim.g.wordmotion_uppercase_spaces = {'/', '.', '{', '}', '(', ')'}
        end
    },
    'mg979/vim-visual-multi',

    {
        'junegunn/vim-easy-align',
        keys = {
            {'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = 'x'},
            {'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign'},
        },
    },
    {
        'Chiel92/vim-autoformat',
        keys = {
            {'[f', '<cmd>Autoformat<cr>', desc = 'Autoformat'},
        },
    },
    {
        'junegunn/rainbow_parentheses.vim',
        config = function(plugin) require'extensions.rainbow' end
    },
    'tpope/vim-commentary',
    {
        'windwp/nvim-autopairs',
        config = function(plugin) require'extensions.autopairs' end
    },
    --'matze/vim-move',
    'wellle/targets.vim',
    {
        "kylechui/nvim-surround",
        config = function(plugin) require'extensions.surround' end
    },
    {
        'simnalamburt/vim-mundo',
        keys = {{'<leader>u', '<cmd>MundoToggle<CR>', desc = 'mundo'}},
    },
    {
        'tversteeg/registers.nvim',
        config = function(plugin) require'registers'.setup() end
    },

    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(plugin) require'extensions.possession' end
    },
}