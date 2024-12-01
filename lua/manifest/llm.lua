local h = require('lazy_helper')

return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- The following are optional:
            { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
        },
        config = h.plugins 'codecompanion',
        enabled = false
    },
    {
        'huggingface/llm.nvim',
        opts = {
            -- cf Setup
        },
        config = h.plugins 'llm',
        enabled = vim.g.nvim_level >= 3,
    },
}
