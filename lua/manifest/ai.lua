local h = require('lazy_helper')
local m = require('setup').mod

return {
    {
        "olimorris/codecompanion.nvim",
        enabled = vim.g.nvim_level >= 2,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = h.settings 'codecompanion',
    },
}
