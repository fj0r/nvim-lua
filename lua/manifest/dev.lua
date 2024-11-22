local h = require('lazy_helper')
local m = require('setup').mod

return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = h.plugins 'luasnip',
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'L3MON4D3/LuaSnip',         -- Snippets plugin
        },
        config = h.plugins 'nvim-cmp',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'neovim/nvim-lspconfig',
        config = h.settings 'lsp',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'b0o/schemastore.nvim',
        enabled = vim.g.nvim_level >= 2,
    },

    --[=[
    'kabouzeid/nvim-lspinstall',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/lsp_extensions.nvim',
    --]=]
    --[[
    {
        'simrat39/symbols-outline.nvim',
        --enabled = vim.g.nvim_level >= 'core',
        config = function(plugin)
            --vim.opt.rtp:append(plugin.dir)
            require 'plugins.outline'
        end
    },
    --]]
    {
        'stevearc/aerial.nvim',
        keys = {
            { '<C-s>',     '<cmd>AerialToggle!<CR>',                                       desc = 'AerialTelescope' },
            { '<leader>s', function() require("telescope").extensions.aerial.aerial() end, desc = 'AerialToggle' }
        },
        config = h.plugins 'aerial',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        --build = ':TSUpdate',
        config = h.settings 'treesitter',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'mizlan/iswap.nvim',
        dependencies = { 'nvim-treesitter' },
        config = h.plugins 'swap',
        enabled = vim.g.nvim_level >= 2,
    },

    {
        'mfussenegger/nvim-dap',
        enabled = vim.g.nvim_level >= 2,
        lazy = true,
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { '[b', 'toggle_breakpoint',    desc = 'dap toggle breakpoint' },
            { '[l', 'list_breakpoints',     desc = 'dap list breakpoints' },
            { '[B', 'condition_breakpoint', desc = 'dap condition breakpoint' },
            { '[L', 'log_breakpoint',       desc = 'dap log breakpoint' },
            { '[c', 'continue',             desc = "dap continue" },
            { '[s', 'step_over',            desc = "dap step over" },
            { '[g', 'goto_',                desc = "dap goto" },
            { '[i', 'step_into',            desc = "dap step into" },
            { '[o', 'step_out',             desc = "dap step out" },
            { '[r', 'run_to_cursor',        desc = "dap run to cursor" },
            { '[x', 'repl_open',            desc = "dap repl open" },
            { '[C', 'run_last',             desc = "dap run last" },
            { '[p', 'stop',                 desc = "dap stop" },
            { '[v', 'eval',                 desc = "dapui eval",              mode = { 'n', 'v' } },
        },
        config = h.settings 'dap',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        enabled = false,
        dependencies = { 'mfussenegger/nvim-dap' }
    },

    {
        "folke/trouble.nvim",
        keys = {
            { '<leader>gw', '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'Diagnostics (Trouble)' },
            { '<leader>gs', '<cmd>Trouble symbols toggle focus=false<cr>',                desc = 'Symbols (Trouble)' },
            { '<leader>gl', '<cmd>Trouble loclist toggle<cr>',                            desc = 'Location List (Trouble)' },
            { '<leader>gq', '<cmd>Trouble qflist toggle<cr>',                             desc = 'Quickfix List (Trouble)' },
            { '<leader>gr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
        },
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = {},
        enabled = vim.g.nvim_level >= 2,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim"
        },
        keys = {
            { '<leader>ga', '<cmd>TodoTelescope<cr>', desc = 'TodoTelescope' },
            { '<leader>gt', '<cmd>TodoTrouble<cr>',   desc = 'TodoTrouble' },
        },
        opts = {},
        enabled = vim.g.nvim_level >= 2,
    },
}
