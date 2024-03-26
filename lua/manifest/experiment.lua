local h = require('lazy_helper')

return {
    {
        "LintaoAmons/scratch.nvim",
        event = "VeryLazy",
        enabled = vim.g.nvim_level >= 2,
    },
    {
        "michaelb/sniprun",
        config = h.plugins 'sniprun',
        enabled = vim.g.nvim_level >= 3,
    },
    {
        'NTBBloodbath/rest.nvim',
        cmd = {
            'RestNvim', 'RestNvimPreview'
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        enabled = false,
    },
    {
        'rafcamlet/nvim-luapad',
        cmd = { 'Luapad', 'LuaRun' },
        enabled = vim.g.nvim_level >= 3,
    },
}
