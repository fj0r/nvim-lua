vim.g.config_root   = debug.getinfo(1,'S').source:match('^@(.+)/.+$')
vim.g.data_root     = os.getenv('HOME') .. '/.nvim'
vim.o.runtimepath   = vim.o.runtimepath .. ',' .. vim.g.config_root
vim.g.nvim_preset   = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'
vim.g.has_git       = pcall(vim.fn.systemlist, { 'git', '--version'})

require 'settings'

--[=[
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
--]=]

vim.cmd [[packadd packer.nvim]]

local packer = require 'packer'

packer.init {
    package_root = vim.g.config_root .. '/pack',
    profile = {
        enable = true,
        threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
        open_fn = require('packer.util').float,
    },
    git = {
        clone_timeout = 600,
    },
}

packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'rcarriga/nvim-notify'
    -- use_rocks 'lua-yaml'

    --[=[
    use {
        'rktjmp/lush.nvim',
        --config = [[require'addons.lush']]
    }
    --]=]
    use {
        "ellisonleao/gruvbox.nvim",
        config = [[vim.cmd'set background=dark|colorscheme gruvbox']]
        --config = [[require'addons.period-themes']]
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = [[require'addons.lualine']],
        --requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = [[require'addons.colorizer']]
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = [[require'addons.telescope']],
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'TC72/telescope-tele-tabby.nvim'
    use 'xiyaowong/telescope-emoji.nvim'
    use "LinArcX/telescope-env.nvim"

    use {
        "folke/trouble.nvim",
        keys = {
            {'n', '<leader>gt', 'TroubleToggle'},
            {'n', '<leader>gw', 'TroubleToggle workspace_diagnostics'},
            {'n', '<leader>ga', 'TroubleToggle document_diagnostics'},
            {'n', '<leader>gl', 'TroubleToggle loclist'},
            {'n', '<leader>gq', 'TroubleToggle quickfix'},
            {'n', '<leader>gr', 'TroubleToggle lsp_references'},
        },
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require'addons.trouble']]
    }

    use {
        's1n7ax/nvim-window-picker',
        keys = {{'n', '<leader><leader>', 'window picker'}},
        module = { 'neo-tree' },
        tag = 'v1.*',
        config = [[require'addons.window-picker']],
    }

    use {
        'sindrets/winshift.nvim',
        keys = {
            {'n', '<leader>ws', 'winshift'},
            {'n', '<leader>wx', 'winswap'},
        },
        config = [[require'addons.winshift']],
    }
    use {
        'notomo/cmdbuf.nvim',
        disable = true,
        config = [[require'addons.cmdbuf']],
    }
    use 'tpope/vim-rsi'
    use {
        "luukvbaal/stabilize.nvim",
        config = [[require'stabilize'.setup()]],
    }
    use {
        'karb94/neoscroll.nvim',
        disable = true,
        config = [[require'neoscroll'.setup()]],
    }
    use {
        'windwp/nvim-spectre',
        disable = true,
        config = [[require'addons.spectre']],
    }

    --[=[
    use {
        'akinsho/nvim-toggleterm.lua',
        keys = {
            {'n', '<leader>xt', 'toggleterm'},
            {'n', '<leader>xy', 'vtoggleterm'},
            {'n', '<leader>xp', 'toggleterm ipython'},
        },
        tag = 'v2.*',
        config = [[require'addons.toggleterm']],
    }
    --]=]

    use {
        "folke/which-key.nvim",
        config = [[require'addons.whichkey']],
    }

    use {
        'stevearc/overseer.nvim',
        keys = {
            {'n', '<leader>ot', 'overseer toggle'},
            {'n', '<leader>oo', 'overseer open'},
            {'n', '<leader>or', 'overseer run'},
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
        config = [[require'addons.overseer']],
    }

    --[=[
    use {
        'pianocomposer321/yabs.nvim',
        keys = {{'n', '<leader>j', 'yabs'}},
        tag = "main",
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = [[require'addons.yabs']],
    }

    use {
        'ggandor/lightspeed.nvim',
        config = [[require'addons.lightspeed']],
        -- requires = { 'tpope/vim-repeat' },
    }
    --]=]
    use {
        'phaazon/hop.nvim',
        branch = 'v2',
        keys = {
            {'n', ';', 'hop hint_words'},
            {'n', 'f', 'hop hint_char1'},
            {'n', 'F', 'hop hint_lines_skip_whitespace'},
        },
        config = [[require'addons.hop']],
    }
    use {
        'kevinhwang91/nvim-hlslens',
        config = [[require'hlslens'.setup()]]
    }
    use {
        'chaoren/vim-wordmotion',
        disable = true,
        config = function ()
            vim.g.wordmotion_uppercase_spaces = {'/', '.', '{', '}', '(', ')'}
        end
    }
    use 'mg979/vim-visual-multi'

    use {
        'junegunn/vim-easy-align',
        keys = {
            {'x', 'ga', 'EasyAlign'},
            {'n', 'ga', 'EasyAlign'},
        },
        config = function ()
            vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
            vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
        end
    }
    use {
        'Chiel92/vim-autoformat',
        keys = {
            {'n', '[f', 'Autoformat'},
        },
        config = function ()
            vim.api.nvim_set_keymap('n', '[f', '<cmd>Autoformat<cr>', {noremap = true})
        end
    }
    use {
        'junegunn/rainbow_parentheses.vim',
        config = [[require'addons.rainbow']]
    }
    use 'tpope/vim-commentary'
    use {
        'windwp/nvim-autopairs',
        config = [[require'addons.autopairs']]
    }


    --use 'matze/vim-move'
    use 'wellle/targets.vim'
    use {
        "kylechui/nvim-surround",
        config = [[require'addons.surround']]
    }

    use {
        'L3MON4D3/LuaSnip',
        requires = {
            'rafamadriz/friendly-snippets',
        },
        config = [[require'addons.luasnip']],
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'L3MON4D3/LuaSnip' -- Snippets plugin
        },
        config = [[require'addons.nvim-cmp']]
    }

    -- vcs
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        -- tag = 'release' -- To use the latest release
        config = [[require'addons.gitsigns']]
    }
    use {
        'sindrets/diffview.nvim',
        keys = {
            {'n', '<leader>gd', 'diffview open'},
            {'n', '<leader>gf', 'diffview file history'},
            {'n', '<leader>gh', 'diffview history'},
        },
        config = [[require'addons.diffview']]
    }
    use {
        'TimUntersberger/neogit',
        keys = {{'n', '<leader>gg', 'neogit'}},
        config = [[require'addons.neogit']],
        requires = { 'nvim-lua/plenary.nvim' },
    }

    --use 'mbbill/undotree'
    use {
        'simnalamburt/vim-mundo',
        keys = {{'n', '<leader>u', 'mundo'}},
        config = function ()
            vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>MundoToggle<CR>', {})
        end
    }
    use {
        'tversteeg/registers.nvim',
        config = [[require'registers'.setup()]]
    }

    use {
        'ojroques/nvim-osc52',
        disable = true, -- by integration terminal
        config = [[require'addons.osc52']],
    }

    --[=[
    use 'tpope/vim-speeddating'
    use {
        'monaqa/dial.nvim',
        config = [[require'addons.dial']]
    }
    --]=]

    use {
        'jbyuki/instant.nvim',
        cmd = {'InstantStartSingle', 'InstantStartSession', 'InstantStartServer'}
        --disable = vim.g.nvim_preset == 'core',
    }

    use {
        'simrat39/symbols-outline.nvim',
        --disable = vim.g.nvim_preset == 'core',
        config = [[require'addons.outline']]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        --run = ':TSUpdate',
        config = function () require 'lang.treesitter' end
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = {'nvim-treesitter'},
        requires = {'nvim-treesitter/nvim-treesitter'}
    }
    use {
        'mizlan/iswap.nvim',
        after = {'nvim-treesitter'},
        config = [[require'addons.swap']]
    }
    --[=[
    use {
        'kyazdani42/nvim-tree.lua',
        config = [[require'addons.tree']],
    }
    --]=]
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                tag = "v1.*",
            }
        },
        keys = {{'n', '<leader>e', 'Neotree'}},
        config = [[require'addons.neotree']],
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require'lang.lsp']],
    }
    use 'b0o/schemastore.nvim'
    --[=[
    use 'kabouzeid/nvim-lspinstall'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/lsp_extensions.nvim'

    use{
        "olimorris/persisted.nvim",
        config = [[require'addons.persisted']],
    }
    --]=]

    use {
        'jedrzejboczar/possession.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require'addons.possession']]
    }

    use {
        'mfussenegger/nvim-dap',
        module = {'dapui'},
        opt = true,
    }
    use {
        'rcarriga/nvim-dap-ui',
        keys = {
            {'n', '[b', 'toggle breakpoint'},
            {'n', '[l', 'list breakpoints'},
            {'n', '[B', 'condition breakpoint'},
            {'n', '[L', 'log breakpoint'},
        },
        config = [[require'lang.dap']],
        requires = {'mfussenegger/nvim-dap'}
    }
    use {
        'theHamsta/nvim-dap-virtual-text',
        disable = true,
        requires = {'mfussenegger/nvim-dap'}
    }

    use {
        'LhKipp/nvim-nu',
        disable = true,
        run = ':TSInstall nu',
        config = [[require'nu'.setup{}]]
    }

    use {
        'NTBBloodbath/rest.nvim',
        keys = {{'n', '<leader>h', 'rest'}},
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require'addons.rest']],
    }

    use {
        'nvim-orgmode/orgmode',
        keys = {
            {'n', '<leader>oa', 'orgmode agenda'},
            {'n', '<leader>oc', 'orgmode capture'},
        },
        ft = {'org'},
        config = [[require'addons.orgmode']],
    }

    use 'seandewar/nvimesweeper'

    use {
        'rafcamlet/nvim-luapad',
        disable = vim.g.nvim_preset == 'core',
        cmd = { 'Luapad', 'LuaRun' },
    }
    --[=[
    use {
        "empat94/nvim-rss",
        disable = vim.g.nvim_preset == 'core',
        requires = { "tami5/sqlite.lua" },
        rocks = { "luaexpat" },
        config = [[require'addons.nvim-rss']],
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
    }
    --]=]

end)

local user_config = os.getenv("HOME") .. '/.nvim.lua'
if vim.fn.empty(vim.fn.glob(user_config)) == 0 then
    vim.cmd('luafile '..user_config)
end
