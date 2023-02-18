local apply_keymap = require('lazy_helper').apply_keymap
return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function(plugin) require 'plugins.luasnip' end,
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
        config = function(plugin) require 'plugins.nvim-cmp' end
    },
    {
        'neovim/nvim-lspconfig',
        config = function(plugin) require 'settings.lsp' end,
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
        config = function(plugin) require 'neodev'.setup {} end,
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
        config = function(plugin)
            require 'plugins.aerial'
            apply_keymap(plugin)
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        --build = ':TSUpdate',
        config = function() require 'settings.treesitter' end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        'mizlan/iswap.nvim',
        dependencies = { 'nvim-treesitter' },
        config = function(plugin) require 'plugins.swap' end
    },

    {
        'mfussenegger/nvim-dap',
        lazy = true,
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { '[b', function() require 'dap'.toggle_breakpoint() end, desc = 'toggle breakpoint' },
            { '[l', function() require 'dap'.list_breakpoints() end, desc = 'list breakpoints' },
            { '[B', function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                desc = 'condition breakpoint' },
            { '[L', function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
                desc = 'log breakpoint' },
        },
        config = function(plugin)
            --vim.opt.rtp:append(plugin.dir)
            require 'settings.dap'
            apply_keymap(plugin)
        end,
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
            { '<leader>gr', '<cmd>TroubleToggle lsp_references<cr>', desc = 'TroubleToggle lsp_references' },
        },
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function(plugin)
            require 'plugins.trouble'
            apply_keymap(plugin)
        end
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { '<leader>ga', '<cmd>TodoTelescope<cr>', desc = 'TodoTelescope' },
            { '<leader>gt', '<cmd>TodoTrouble<cr>', desc = 'TodoTrouble' },
        },
        config = function(plugin)
            require 'plugins.todo-comments'
            apply_keymap(plugin)
        end,
    },
}
