return {
    {
        "luukvbaal/stabilize.nvim",
        config = function(plugin) require 'stabilize'.setup() end,
    },
    {
        'karb94/neoscroll.nvim',
        enabled = false,
        config = function(plugin) require 'neoscroll'.setup() end,
    },
    {
        'windwp/nvim-spectre',
        enabled = false,
        config = function(plugin) require 'plugins.spectre' end,
    },
    {
        'ojroques/nvim-osc52',
        enabled = false, -- by integration terminal
        config = function(plugin) require 'plugins.osc52' end,
    },

    --remote-wait
    {
        "samjwill/nvim-unception",
        -- enabled = vim.g.nvim_preset ~= 'core',
    }
}
