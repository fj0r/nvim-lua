local h = require('lazy_helper')

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
            'L3MON4D3/LuaSnip' -- Snippets plugin
        },
        config = h.plugins 'nvim-cmp'
    },
    {
        'neovim/nvim-lspconfig',
        config = h.settings 'lsp',
    },
    'b0o/schemastore.nvim',
    --[=[
    'kabouzeid/nvim-lspinstall',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/lsp_extensions.nvim',
    --]=]

    {
        "folke/neodev.nvim",
        dependencies = { 'neovim/nvim-lspconfig' },
        enabled = vim.g.nvim_preset ~= 'core',
        opts = {}
    },
    --[[
    {
        'simrat39/symbols-outline.nvim',
        --enabled = vim.g.nvim_preset ~= 'core',
        config = function(plugin)
            --vim.opt.rtp:append(plugin.dir)
            require 'plugins.outline'
        end
    },
    --]]
    {
        'stevearc/aerial.nvim',
        keys = {
            { '<C-s>', '<cmd>AerialToggle!<CR>', desc = 'AerialTelescope' },
            { '<leader>s', function() require("telescope").extensions.aerial.aerial() end, desc = 'AerialToggle' }
        },
        config = h.plugins 'aerial',
    },

    {
        'nvim-treesitter/nvim-treesitter',
        --build = ':TSUpdate',
        config = h.settings 'treesitter'
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        'mizlan/iswap.nvim',
        dependencies = { 'nvim-treesitter' },
        config = h.plugins 'swap'
    },

    {
        'mfussenegger/nvim-dap',
        lazy = true,
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { '[b', function() require 'dap'.toggle_breakpoint() end, desc = 'dap toggle breakpoint' },
            { '[l', function() require 'dap'.list_breakpoints() end, desc = 'dap list breakpoints' },
            { '[B', function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                desc = 'dap condition breakpoint' },
            { '[L', function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
                desc = 'dap log breakpoint' },
        },
        config = h.settings 'dap',
        dependencies = { 'mfussenegger/nvim-dap' }
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        enabled = false,
        dependencies = { 'mfussenegger/nvim-dap' }
    },

    {
        "folke/trouble.nvim",
        keys = {
            { '<leader>gw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'TroubleToggle workspace_diagnostics' },
            { '<leader>ga', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'TroubleToggle document_diagnostics' },
            { '<leader>gl', '<cmd>TroubleToggle loclist<cr>', desc = 'TroubleToggle loclist' },
            { '<leader>gq', '<cmd>TroubleToggle quickfix<cr>', desc = 'TroubleToggle quickfix' },
            --{ '<leader>gr', '<cmd>TroubleToggle lsp_references<cr>', desc = 'TroubleToggle lsp_references' },
        },
        dependencies = "kyazdani42/nvim-web-devicons",
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
        keys = {
            { '<leader>ga', '<cmd>TodoTelescope<cr>', desc = 'TodoTelescope' },
            { '<leader>gt', '<cmd>TodoTrouble<cr>', desc = 'TodoTrouble' },
        },
        opts = {},
    },
}
