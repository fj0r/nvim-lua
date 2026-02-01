local h = require('lazy_helper')

return {
    -- TODO: remove
    {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'folke/snacks.nvim',
        },
        cmd = 'Nerdy',
        opts = {
            max_recents = 30, -- Configure recent icons limit
            copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
            copy_register = '+', -- Register to use for copying (if `copy_to_clipboard` is true)
        },
        config = h.settings 'nerdy',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        "LintaoAmons/scratch.nvim",
        tag = "v0.13.2",
        event = "VeryLazy",
        enabled = vim.g.nvim_level >= 3,
    },
    {
        "michaelb/sniprun",
        config = h.settings 'sniprun',
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
