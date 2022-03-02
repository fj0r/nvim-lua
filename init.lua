vim.g.config_root   = debug.getinfo(1,'S').source:match('^@(.+)/.+$')
vim.g.data_root     = os.getenv('HOME') .. '/.vim.data'
--vim.g.config_root = vim.fn.stdpath('config')
vim.o.runtimepath   = vim.o.runtimepath .. ',' .. vim.g.config_root
vim.g.nvim_preset   = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'

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

    use {
        'RRethy/nvim-base16',
        config = [[require'addons.base16-themes']]
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = [[require'addons.lualine']],
        --requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    --use 'rktjmp/lush.nvim'
    use {
        'norcalli/nvim-colorizer.lua',
        config = [[require'addons.colorizer']]
    }

    use {
        't9md/vim-choosewin',
        config = function ()
            vim.api.nvim_set_keymap('n', '-', '<Plug>(choosewin)', {})
            vim.g.choosewin_overlay_enable = 0
            vim.g.choosewin_label          = 'ASDFQWERZXCV'
        end
    }

    use {
        'pianocomposer321/yabs.nvim',
        config = [[require'addons.yabs']],
        requires = { 'nvim-lua/plenary.nvim' },
    }
    --use 'skywind3000/asyncrun.vim'
    --use {
    --    'skywind3000/asynctasks.vim',
    --    config = function ()
    --        vim.cmd('so ' .. vim.g.config_root .. '/config/asynctasks.vim')
    --    end
    --}
    --use 'GustavoKatel/telescope-asynctasks.nvim'

    use {
        'akinsho/nvim-toggleterm.lua',
        config = [[require'addons.toggleterm']],
    }
    --use 'skywind3000/vim-terminal-help'
    --use 'kassio/neoterm'

    --use {
    --    'ggandor/lightspeed.nvim',
    --    config = [[require'addons.lightspeed']],
    --    -- requires = { 'tpope/vim-repeat' },
    --}
    use {
        'phaazon/hop.nvim',
        config = [[require'addons.hop']],
    }
    use 'kevinhwang91/nvim-hlslens'
    use {
        'chaoren/vim-wordmotion',
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
            vim.api.nvim_set_keymap('n', '<F2>', '<cmd>Autoformat<cr>', {noremap = true})
        end
    }
    use {
        'junegunn/rainbow_parentheses.vim',
        config = [[require'addons.rainbow']]
    }
    use 'tpope/vim-commentary'
    use 'jiangmiao/auto-pairs'

    --use 'matze/vim-move'
    use 'wellle/targets.vim'
    --use 'machakann/vim-sandwich'
    use 'tpope/vim-surround'
    --use {
    --    'blackCauldron7/surround.nvim',
    --    config = [[require'addons.surround']]
    --}

    use {
        'hrsh7th/nvim-compe',
        config = [[require'addons.compe']]
    }
    --use 'norcalli/snippets.nvim'
    use 'hrsh7th/vim-vsnip'
    --use 'hrsh7th/vim-vsnip-integ'
    --use 'SirVer/ultisnips'

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
    -- use {
    --     'ojroques/vim-oscyank',
    --     config = function ()
    --         vim.g.oscyank_max_length = 1000
    --         vim.cmd [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
    --     end
    -- }

    --use 'tpope/vim-speeddating'
    --use {
    --    'monaqa/dial.nvim',
    --    config = [[require'addons.dial']]
    --}

    use 'jbyuki/instant.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        config = [[require'addons.telescope']],
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'TC72/telescope-tele-tabby.nvim'
    use 'xiyaowong/telescope-emoji.nvim'
    use "LinArcX/telescope-env.nvim"

    use {
        'simrat39/symbols-outline.nvim',
        config = [[require'addons.outline']]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        --disable = vim.g.nvim_preset == 'core',
        run = ':TSUpdate',
        config = function () require 'lang.treesitter' end
    }
    -- use {
    --     'nvim-treesitter/nvim-treesitter-textobjects',
    --     --disable = vim.g.nvim_preset == 'core',
    --     after = {'nvim-treesitter'},
    --     requires = {'nvim-treesitter/nvim-treesitter'}
    -- }
    use {
        'mizlan/iswap.nvim',
        --disable = vim.g.nvim_preset == 'core',
        after = {'nvim-treesitter'},
        config = [[require'addons.swap']]
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = [[require'addons.tree']],
    }
    use {
        'neovim/nvim-lspconfig',
        config = [[require'lang.lsp']],
    }
    --use 'kabouzeid/nvim-lspinstall'
    --use 'nvim-lua/lsp-status.nvim'
    --use 'nvim-lua/lsp_extensions.nvim'

    use {
        'rmagatti/auto-session',
        config = [[require'addons.auto-session']]
    }
    --use 'thaerkh/vim-workspace'

    use {
        'mfussenegger/nvim-dap',
        config = [[require'lang.dap']],
    }

    use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
    use {'theHamsta/nvim-dap-virtual-text', disable = true, requires = {'mfussenegger/nvim-dap'} }

    --use {
    --    'nanotee/sqls.nvim'
    --}
    --use 'chr4/nginx.vim'
    --use 'keith/swift.vim'
    use {
        'NTBBloodbath/rest.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require'addons.rest']],
    }

    --use 'johngrib/vim-game-snake'
end)

