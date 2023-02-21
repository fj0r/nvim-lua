local h = require('lazy_helper')

return {
    {
        'LhKipp/nvim-nu',
        enabled = false,
        build = ':TSInstall nu',
        opts = {}
    },
    {
        'nvim-orgmode/orgmode',
        keys = {
            { '<leader>oa', nil, desc = 'orgmode agenda' },
            { '<leader>oc', nil, desc = 'orgmode capture' },
        },
        ft = { 'org' },
        config = h.plugins 'orgmode',
    },
    {
        'NTBBloodbath/rest.nvim',
        keys = {
            { '<leader>H', '<Plug>RestNvim', desc = 'rest' },
            { '<leader>h', '<Plug>RestNvimPreview', desc = 'rest' },
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = h.plugins 'rest',
    },
    {
        'rafcamlet/nvim-luapad',
        enabled = vim.g.nvim_preset ~= 'core',
        cmd = { 'Luapad', 'LuaRun' },
    },
    {
        'towolf/vim-helm',
        enabled = vim.g.nvim_preset ~= 'core',
    }
}
