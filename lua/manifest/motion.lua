return {
    {
        'ggandor/lightspeed.nvim',
        config = function(plugin) require'plugins.lightspeed' end,
    },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        keys = {
            --[[ standalone
            {';', nil, desc = 'hop hint_words'},
            {',', nil, desc = 'hop hint_char1'},
            {'s', nil, desc = 'hop hint_char2'},
            {'<leader>;', nil, desc = 'hop hint_lines'},
            --]]
            {'<leader><leader>', nil, desc = 'hop hint_words'},
            {'<leader>;', nil, desc = 'hop hint_lines'},
        },
        config = function(plugin) require'plugins.hop' end,
    },
    {
        'chaoren/vim-wordmotion',
        enabled = false,
        config = function ()
            vim.g.wordmotion_uppercase_spaces = {'/', '.', '{', '}', '(', ')'}
        end
    },
    --'matze/vim-move',
    'wellle/targets.vim',
    {
        "kylechui/nvim-surround",
        config = function(plugin) require'plugins.surround' end
    },
}
