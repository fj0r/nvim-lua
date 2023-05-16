local h = require('lazy_helper')

return {
    {
        'ggandor/lightspeed.nvim',
        keys = {
            { 's', '<Plug>Lightspeed_omni_s', desc = 'Lightspeed_omni_s'},
            { 'S', '<Plug>Lightspeed_omni_gs', desc = 'Lightspeed_omni_gs'},
        },
        config = h.plugins 'lightspeed',
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
            { '<leader><leader>', 'hint_somewhere', desc = 'hop hint_words', mode = { 'n', 'v' } },
            { '<leader>;', 'hint_lines', desc = 'hop hint_lines', mode = { 'n', 'v' } },
        },
        config = h.plugins 'hop',
    },
    {
        'chaoren/vim-wordmotion',
        enabled = false,
        config = function()
            vim.g.wordmotion_uppercase_spaces = { '/', '.', '{', '}', '(', ')' }
        end
    },
    --'matze/vim-move',
    'wellle/targets.vim',
}
