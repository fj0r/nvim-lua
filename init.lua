vim.g.config_root  = debug.getinfo(1,'S').source:match('^@(.+)/.+$')
vim.g.data_root    = os.getenv('HOME') .. '/.nvim'
vim.g.nvim_preset  = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'
vim.g.has_git      = pcall(vim.fn.systemlist, { 'git', '--version'})
vim.opt.runtimepath:prepend(vim.g.config_root)

require 'settings'

local lazypath = vim.g.config_root .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    -- use_rocks 'lua-yaml'

    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = function(plugin) require'addons.lush' end
    }
    --]=]
    {
        "ellisonleao/gruvbox.nvim",
        config = function(plugin)
            vim.cmd'set background=dark|colorscheme gruvbox'
            --require'addons.period-themes'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        config = function(plugin) require'addons.lualine' end,
        --dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function(plugin) require'addons.colorizer' end
    },

    {
        'nvim-telescope/telescope.nvim',
        config = function(plugin) require'addons.telescope' end,
        dependencies = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    },
    'TC72/telescope-tele-tabby.nvim',
    'xiyaowong/telescope-emoji.nvim',
    "LinArcX/telescope-env.nvim",

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
        config = function(plugin) require'addons.trouble' end
    },

    {
        's1n7ax/nvim-window-picker',
        keys = {{'<leader><leader>', nil, desc = 'window picker'}},
        module = { 'neo-tree' },
        version = 'v1.*',
        config = function(plugin) require'addons.window-picker' end,
    },

    {
        'sindrets/winshift.nvim',
        keys = {
            {'<leader>ws', nil, desc = 'winshift'},
            {'<leader>wx', nil, desc = 'winswap'},
        },
        config = function(plugin) require'addons.winshift' end,
    },
    {
        'notomo/cmdbuf.nvim',
        enabled = false,
        config = function(plugin) require'addons.cmdbuf' end,
    },
    'tpope/vim-rsi',
    {
        "luukvbaal/stabilize.nvim",
        config = function(plugin) require'stabilize'.setup() end,
    },
    {
        'karb94/neoscroll.nvim',
        enabled = false,
        config = function(plugin) require'neoscroll'.setup() end,
    },
    {
        'windwp/nvim-spectre',
        enabled = false,
        config = function(plugin) require'addons.spectre' end,
    },

    {
        'fj0r/nvim-taberm',
        config = function(plugin) require'taberm'.setup{} end,
    },
    --[=[
    {
        'akinsho/nvim-toggleterm.lua',
        keys = {
            {'<leader>xt', nil, desc = 'toggleterm'},
            {'<leader>xy', nil, desc = 'vtoggleterm'},
            {'<leader>xp', nil, desc = 'toggleterm ipython'},
        },
        version = 'v2.*',
        config = function(plugin) require'addons.toggleterm' end,
    },
    --]=]

    {
        "folke/which-key.nvim",
        config = function(plugin) require'addons.whichkey' end,
    },

    {
        'stevearc/overseer.nvim',
        lazy = true,
        keys = {
            {'<leader>ot', nil, desc = 'overseer toggle'},
            {'<leader>oo', nil, desc = 'overseer open'},
            {'<leader>or', nil, desc = 'overseer run'},
        },
        cmd = {
            'OverseerRun',
            'OverseerOpen',
            'OverseerBuild',
            'OverseerToggle',
            'OverseerRunCmd',
            'OverseerQuickAction',
            'OverseerTaskAction'
        },
        config = function(plugin) require'addons.overseer' end,
    },

    --[=[
    {
        'pianocomposer321/yabs.nvim',
        keys = {{'<leader>j', nil, desc = 'yabs'}},
        version = "main",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function(plugin) require'addons.yabs' end,
    },

    {
        'ggandor/lightspeed.nvim',
        config = function(plugin) require'addons.lightspeed' end,
        -- dependencies = { 'tpope/vim-repeat' },
    },
    --]=]
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        keys = {
            {';', nil, desc = 'hop hint_words'},
            {'f', nil, desc = 'hop hint_char1'},
            {'F', nil, desc = 'hop hint_lines_skip_whitespace'},
        },
        config = function(plugin) require'addons.hop' end,
    },
    {
        'kevinhwang91/nvim-hlslens',
        config = function(plugin) require'hlslens'.setup() end
    },
    {
        'chaoren/vim-wordmotion',
        enabled = false,
        config = function ()
            vim.g.wordmotion_uppercase_spaces = {'/', '.', '{', '}', '(', ')'}
        end
    },
    'mg979/vim-visual-multi',

    {
        'junegunn/vim-easy-align',
        keys = {
            {'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = 'x'},
            {'ga', '<Plug>(EasyAlign)', desc = 'EasyAlign'},
        },
    },
    {
        'Chiel92/vim-autoformat',
        keys = {
            {'[f', '<cmd>Autoformat<cr>', desc = 'Autoformat'},
        },
    },
    {
        'junegunn/rainbow_parentheses.vim',
        config = function(plugin) require'addons.rainbow' end
    },
    'tpope/vim-commentary',
    {
        'windwp/nvim-autopairs',
        config = function(plugin) require'addons.autopairs' end
    },


    --'matze/vim-move',
    'wellle/targets.vim',
    {
        "kylechui/nvim-surround",
        config = function(plugin) require'addons.surround' end
    },

    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function(plugin) require'addons.luasnip' end,
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
        config = function(plugin) require'addons.nvim-cmp' end
    },

    -- vcs
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        -- version = 'release' -- To use the latest release
        config = function(plugin) require'addons.gitsigns' end
    },
    {
        'sindrets/diffview.nvim',
        keys = {
            {'<leader>gd', nil, desc = 'diffview open'},
            {'<leader>gf', nil, desc = 'diffview file history'},
            {'<leader>gh', nil, desc = 'diffview history'},
        },
        config = function(plugin) require'addons.diffview' end
    },
    {
        'TimUntersberger/neogit',
        keys = {{'<leader>gg', nil, desc = 'neogit'}},
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir)
            require'addons.neogit'
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    --'mbbill/undotree',
    {
        'simnalamburt/vim-mundo',
        keys = {{'<leader>u', '<cmd>MundoToggle<CR>', desc = 'mundo'}},
    },
    {
        'tversteeg/registers.nvim',
        config = function(plugin) require'registers'.setup() end
    },

    {
        'ojroques/nvim-osc52',
        enabled = false, -- by integration terminal
        config = function(plugin) require'addons.osc52' end,
    },

    --[=[
    'tpope/vim-speeddating',
    {
        'monaqa/dial.nvim',
        config = function(plugin) require'addons.dial' end
    },
    --]=]

    {
        'jbyuki/instant.nvim',
        cmd = {'InstantStartSingle', 'InstantStartSession', 'InstantStartServer'}
        --enabled = vim.g.nvim_preset ~= 'core',
    },

    {
        'simrat39/symbols-outline.nvim',
        --enabled = vim.g.nvim_preset ~= 'core',
        config = function(plugin) require'addons.outline' end
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
        config = function(plugin) require'addons.swap' end
    },
    --[=[
    {
        'kyazdani42/nvim-tree.lua',
        config = function(plugin) require'addons.tree' end,
    },
    --]=]
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                version = "v1.*",
            }
        },
        keys = {{'<leader>e', nil, desc = 'Neotree'}},
        config = function(plugin) require'addons.neotree' end,
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

    {
        "olimorris/persisted.nvim",
        config = function(plugin) require'addons.persisted' end,
    },
    --]=]

    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(plugin) require'addons.possession' end
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
        config = function(plugin) require'lang.dap' end,
        dependencies = {'mfussenegger/nvim-dap'}
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        enabled = false,
        dependencies = {'mfussenegger/nvim-dap'}
    },

    {
        'LhKipp/nvim-nu',
        enabled = false,
        build = ':TSInstall nu',
        config = function(plugin) require'nu'.setup{} end
    },

    {
        'NTBBloodbath/rest.nvim',
        keys = {{'<leader>h', nil, desc = 'rest'}},
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(plugin) require'addons.rest' end,
    },

    {
        'nvim-orgmode/orgmode',
        keys = {
            {'<leader>oa', nil, desc = 'orgmode agenda'},
            {'<leader>oc', nil, desc = 'orgmode capture'},
        },
        ft = {'org'},
        config = function(plugin) require'addons.orgmode' end,
    },

    'seandewar/nvimesweeper',

    {
        'glacambre/firenvim',
        enabled = vim.g.nvim_preset ~= 'core',
        build = function() vim.fn['firenvim#install'](0) end
    },

    {
        'rafcamlet/nvim-luapad',
        enabled = vim.g.nvim_preset ~= 'core',
        cmd = { 'Luapad', 'LuaRun' },
    },
    --[=[
    {
        "empat94/nvim-rss",
        enabled = vim.g.nvim_preset ~= 'core',
        dependencies = { "tami5/sqlite.lua" },
        rocks = { "luaexpat" },
        config = function(plugin) require'addons.nvim-rss' end,
        cmd = {
            'OpenRssView',
            'FetchFeed',
            'FetchAllFeeds',
            'FetchFeedsByCategory',
            'FetchSelectedFeeds',
            'ViewFeed',
            'CleanFeed',
            'ResetDB',
            'ImportOpml',
        },
    },
    --]=]
},
{
    root = vim.g.config_root .. "/lazy"
})

local user_config = os.getenv("HOME") .. '/.nvim.lua'
if vim.fn.empty(vim.fn.glob(user_config)) == 0 then
    vim.cmd('luafile '..user_config)
end
