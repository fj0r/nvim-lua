vim.g.config_root   = debug.getinfo(1,'S').source:match('^@(.+)/.+$')
vim.g.data_root     = os.getenv('HOME') .. '/.vim.data'
vim.o.runtimepath   = vim.o.runtimepath .. ',' .. vim.g.config_root
vim.g.nvim_preset   = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'
--[[
vim.g.packer_path   = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
--]]

require 'settings'


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
    -- use_rocks 'lua-yaml'

    --[=[
    use {
        'overcache/NeoSolarized',
        disable = vim.g.nvim_preset == 'core',
        --config = [[vim.cmd'colorscheme NeoSolarized | set background=light']]
    }
    use {
        --'ellisonleao/gruvbox.nvim',
        'fj0r/gruvbox.nvim',
        config = [[require'addons.theme']]
        --config = [[require'addons.period-themes']]
    }
    use {
        'rktjmp/lush.nvim',
        --config = [[require'addons.lush']]
    }
    --]=]
    use {
        "ellisonleao/gruvbox.nvim",
        config = [[vim.cmd'set background=dark|colorscheme gruvbox']]
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

    --[=[
    use {
        'https://gitlab.com/yorickpeterse/nvim-window.git',
        config = [[require'addons.window']],
    }
    --]=]
    use {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = [[require'addons.window-picker']],
    }

    use {
        'sindrets/winshift.nvim',
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
        'akinsho/nvim-toggleterm.lua',
        tag = 'v2.*',
        config = [[require'addons.toggleterm']],
    }

    use {
        'pianocomposer321/yabs.nvim',
        tag = "main",
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = [[require'addons.yabs']],
    }
    -- use {
    --     'jedrzejboczar/toggletasks.nvim',
    --     requires = {
    --         'nvim-lua/plenary.nvim',
    --         'akinsho/nvim-toggleterm.lua',
    --         'nvim-telescope/telescope.nvim',
    --     },
    --     config = [[require'addons.toggletasks']],
    --     -- To enable YAML config support
    --     -- rocks = 'lyaml',
    -- }

    --[=[
    use 'skywind3000/vim-terminal-help'
    use 'kassio/neoterm'

    use {
        'ggandor/lightspeed.nvim',
        config = [[require'addons.lightspeed']],
        -- requires = { 'tpope/vim-repeat' },
    }
    --]=]
    use {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = [[require'addons.hop']],
    }
    use 'kevinhwang91/nvim-hlslens'
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
        config = function ()
            vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
            vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
        end
    }
    use {
        'Chiel92/vim-autoformat',
        config = function ()
            vim.api.nvim_set_keymap('n', '[f', '<cmd>Autoformat<cr>', {noremap = true})
        end
    }
    use {
        'junegunn/rainbow_parentheses.vim',
        config = [[require'addons.rainbow']]
    }
    use 'tpope/vim-commentary'
    -- use 'jiangmiao/auto-pairs'
    use {
        'windwp/nvim-autopairs',
        config = [[require'addons.autopairs']]
    }


    --use 'matze/vim-move'
    use 'wellle/targets.vim'
    --use 'machakann/vim-sandwich'
    --use 'tpope/vim-surround'
    use {
        "kylechui/nvim-surround",
        config = [[require'addons.surround']]
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
    --[=[
    use {
        'hrsh7th/nvim-compe',
        config = [[require'addons.compe']]
    }
    use 'norcalli/snippets.nvim'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'SirVer/ultisnips'
    --]=]

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        -- tag = 'release' -- To use the latest release
        config = [[require'addons.gitsigns']]
    }

    use {
        'TimUntersberger/neogit',
        config = [[require'addons.neogit']],
        requires = { 'nvim-lua/plenary.nvim' },
    }
    --use 'mbbill/undotree'
    use {
        'simnalamburt/vim-mundo',
        config = function ()
            vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>MundoToggle<CR>', {})
        end
    }
    use 'tversteeg/registers.nvim'
    use {
        'ojroques/nvim-osc52',
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
        --disable = vim.g.nvim_preset == 'core',
    }

    use {
        'simrat39/symbols-outline.nvim',
        --disable = vim.g.nvim_preset == 'core',
        config = [[require'addons.outline']]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        --disable = vim.g.nvim_preset == 'core',
        --run = ':TSUpdate',
        config = function () require 'lang.treesitter' end
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        --disable = vim.g.nvim_preset == 'core',
        after = {'nvim-treesitter'},
        requires = {'nvim-treesitter/nvim-treesitter'}
    }
    use {
        'mizlan/iswap.nvim',
        --disable = vim.g.nvim_preset == 'core',
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
        'neovim/nvim-lspconfig',
        config = [[require'lang.lsp']],
    }
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
    --[=[
    use {
        'rmagatti/auto-session',
        disable = true,
        config = [[require'addons.auto-session']]
    }

    use {
        'rmagatti/session-lens',
        disable = vim.g.nvim_preset == 'core',
        requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
        config = function()
            require('session-lens').setup({ })
        end
    }
    --]=]

    use {
        'mfussenegger/nvim-dap',
        config = [[require'lang.dap']],
    }

    use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
    use { 'theHamsta/nvim-dap-virtual-text', disable = true, requires = {'mfussenegger/nvim-dap'} }

    --[[
    use {
        'nanotee/sqls.nvim'
    }
    use 'chr4/nginx.vim'
    use 'keith/swift.vim'
    --]]

    use {
        'LhKipp/nvim-nu',
        --disable = vim.g.nvim_preset == 'core',
        disable = true,
        run = ':TSInstall nu',
        config = [[require'nu'.setup{}]]
    }

    use {
        'NTBBloodbath/rest.nvim',
        disable = vim.g.nvim_preset == 'core',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require'addons.rest']],
    }

    use {
        "nvim-neorg/neorg",
        -- tag = "latest",
        ft = "norg",
        disable = true,
        after = "nvim-treesitter", -- You may want to specify Telescope here as well
        requires = "nvim-neorg/neorg-telescope",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Load all the defaults
                    ["core.integrations.telescope"] = {}, -- Enable the telescope module
                },
            }
        end
    }

    use {
        "aserowy/tmux.nvim",
        disable = true,
        config = [[require'addons.tmux']],
    }
    use 'seandewar/nvimesweeper'

end)

