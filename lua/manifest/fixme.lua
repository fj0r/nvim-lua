local h = require('lazy_helper')

return {
    {
        "luukvbaal/stabilize.nvim",
        opts = {},
        enabled = false,
    },
    {
        'karb94/neoscroll.nvim',
        enabled = false,
        opts = {}
    },
    {
        'ojroques/nvim-osc52',
        enabled = false, -- by integration terminal
        config = h.plugins 'osc52',
    },

    --remote-wait
    {
        "samjwill/nvim-unception",
        enabled = false,
    },
    {
        "willothy/flatten.nvim",
        opts = {
            window = {
            }
        },
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
    },
}
