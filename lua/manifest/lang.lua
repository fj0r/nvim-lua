local h = require('lazy_helper')

return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'LhKipp/nvim-nu',
        build = ':TSInstall nu',
        enabled = vim.g.nvim_level >= 3,
    },
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        enabled = vim.g.nvim_level >= 3,
    },
    {
        "nvim-neorg/neorg",
        --build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = h.plugins 'neorg',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'nvim-orgmode/orgmode',
        keys = {
            { '<leader>oa', nil, desc = 'orgmode agenda' },
            { '<leader>oc', nil, desc = 'orgmode capture' },
        },
        ft = { 'org' },
        config = h.plugins 'orgmode',
        enabled = false,
    },
    {
        'NTBBloodbath/rest.nvim',
        cmd = {
            'RestNvim', 'RestNvimPreview'
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'rafcamlet/nvim-luapad',
        cmd = { 'Luapad', 'LuaRun' },
        enabled = vim.g.nvim_level >= 3,
    },
    {
        'towolf/vim-helm',
        enabled = vim.g.nvim_level >= 3,
    }
}
