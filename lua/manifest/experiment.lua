local h = require('lazy_helper')

return {
    -- TODO: remove
    {
        "LintaoAmons/scratch.nvim",
        tag = "v0.13.2",
        event = "VeryLazy",
        enabled = vim.g.nvim_level >= 3,
    },
    {
        "michaelb/sniprun",
        config = h.plugins 'sniprun',
        enabled = false,
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
