return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function(plugin) require'extensions.luasnip' end,
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
        config = function(plugin) require'extensions.nvim-cmp' end
    },
    {
        'neovim/nvim-lspconfig',
        config = function(plugin) require'lang.lsp' end,
    },
    'b0o/schemastore.nvim',
    --[=[
    'kabouzeid/nvim-lspinstall',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/lsp_extensions.nvim',
    --]=]

    {
        'simrat39/symbols-outline.nvim',
        --enabled = vim.g.nvim_preset ~= 'core',
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir)
            require'extensions.outline'
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        --build = ':TSUpdate',
        config = function () require 'lang.treesitter' end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {'nvim-treesitter/nvim-treesitter'}
    },
    {
        'mizlan/iswap.nvim',
        dependencies = {'nvim-treesitter'},
        config = function(plugin) require'extensions.swap' end
    },

    {
        'mfussenegger/nvim-dap',
        lazy = true,
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            {'[b', nil, desc = 'toggle breakpoint'},
            {'[l', nil, desc = 'list breakpoints'},
            {'[B', nil, desc = 'condition breakpoint'},
            {'[L', nil, desc = 'log breakpoint'},
        },
        config = function(plugin)
            --vim.opt.rtp:append(plugin.dir)
            require'lang.dap'
        end,
        dependencies = {'mfussenegger/nvim-dap'}
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        enabled = false,
        dependencies = {'mfussenegger/nvim-dap'}
    },

    {
        "folke/trouble.nvim",
        keys = {
            {'<leader>gt', nil, desc = 'TroubleToggle'},
            {'<leader>gw', nil, desc = 'TroubleToggle workspace_diagnostics'},
            {'<leader>ga', nil, desc = 'TroubleToggle document_diagnostics'},
            {'<leader>gl', nil, desc = 'TroubleToggle loclist'},
            {'<leader>gq', nil, desc = 'TroubleToggle quickfix'},
            {'<leader>gr', nil, desc = 'TroubleToggle lsp_references'},
        },
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function(plugin) require'extensions.trouble' end
    },
}
