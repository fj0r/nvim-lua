local h = require('lazy_helper')

return {
    {
        "luukvbaal/stabilize.nvim",
        opts = {}
    },
    {
        'karb94/neoscroll.nvim',
        enabled = false,
        opts = {}
    },
    {
        'windwp/nvim-spectre',
        enabled = false,
        config = h.plugins 'spectre',
    },
    {
        'ojroques/nvim-osc52',
        enabled = false, -- by integration terminal
        config = h.plugins 'osc52',
    },

    --remote-wait
    {
        "samjwill/nvim-unception",
        enabled = true
        -- enabled = vim.g.nvim_preset ~= 'core',
    }
}
