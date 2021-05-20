vim.g.config_root = debug.getinfo(1,'S').source:match("^@(.+)/.+$")
--vim.g.config_root = vim.fn.stdpath('config')
vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.g.config_root
vim.g.nvim_preset = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'
vim.g.bootstrap   = os.getenv('NVIM_BOOTSTRAP') == '1'
vim.g.BASE16_THEME = os.getenv('NVIM_THEME') or 'base16-gruvbox-dark-hard'

vim.cmd [[packadd packer.nvim]]

local packer = require 'packer'

packer.init {
    package_root = vim.g.config_root .. '/pack',
    profile = {
        enable = true,
        threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    }
}

packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'RRethy/nvim-base16',
        config = function ()
            vim.cmd('colorscheme '..vim.g.BASE16_THEME)
        end
    }
    use {
        'norcalli/nvim-base16.lua',
        requires = {'norcalli/nvim.lua'},
        disable = true,
        config = function ()
            local base16 = require 'base16'
            base16(base16.themes[vim.g.BASE16_THEME], true)
        end
    }
    --use 'rktjmp/lush.nvim'
    use 'norcalli/nvim-colorizer.lua'

    --use 'vim-airline/vim-airline'
    --use 'vim-airline/vim-airline-themes'
    --use 'ompugao/vim-airline-datetime'
    --use 'itchyny/lightline.vim'
    --use 'niklaas/lightline-gitdiff'
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = "require'addons.galaxyline'"
    }
    use {
        't9md/vim-choosewin',
        config = function ()
            vim.api.nvim_set_keymap('n', '-', '<Plug>(choosewin)', {})
            vim.g.choosewin_overlay_enable = 0
            vim.g.choosewin_label          = "ASDFQWERZXCV"
        end
    }

    use 'skywind3000/asyncrun.vim'
    use 'skywind3000/asynctasks.vim'
    use 'GustavoKatel/telescope-asynctasks.nvim'

    use {
        'akinsho/nvim-toggleterm.lua',
        config = "require'addons.toggleterm'",
    }
    --use 'skywind3000/vim-terminal-help'
    --use 'kassio/neoterm'

    --use 't9md/vim-smalls'
    use {
        'justinmk/vim-sneak',
        config = "require'addons.sneak'"
    }
    use 'kevinhwang91/nvim-hlslens'
    use {
        'chaoren/vim-wordmotion',
        config = function ()
            vim.g.wordmotion_uppercase_spaces = {'/', '.', '{', '}', '(', ')'}
        end
    }
    --use 'easymotion/vim-easymotion'
    use 'mg979/vim-visual-multi'

    --use 'jiangmiao/auto-pairs'
    use 'windwp/nvim-autopairs'
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
        config = "require'addons.rainbow'"
    }
    use 'tpope/vim-commentary'

    --use 'matze/vim-move'
    use 'wellle/targets.vim'
    --use 'machakann/vim-sandwich'
    use 'tpope/vim-surround'
    use 'machakann/vim-swap'

    use {
        'hrsh7th/nvim-compe',
        config = "require'addons.compe'"
    }
    --use 'norcalli/snippets.nvim'
    use 'hrsh7th/vim-vsnip'
    --use 'hrsh7th/vim-vsnip-integ'
    --use 'SirVer/ultisnips'

    --use 'tpope/vim-fugitive'
    use {
        'TimUntersberger/neogit',
        config = "require'addons.neogit'",
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
        'ojroques/vim-oscyank',
        config = function ()
            vim.g.oscyank_max_length = 1000
            vim.api.nvim_command("autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif")
        end
    }
    use {
        'vhyrro/neorg',
        config = function()
            require('neorg').setup {
                load = {
                    ["core.org.headings"] = {},
                    ['core.defaults'] = {} -- Load all the default modules
                },
            }
        end,
        requires = { 'nvim-lua/plenary.nvim' }
    }
    --use 'tpope/vim-speeddating'
    use 'jbyuki/instant.nvim'

    use 'nvim-lua/popup.nvim'
    -- use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        config = "require'addons.telescope'"
    }
    use 'TC72/telescope-tele-tabby.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function () require 'lang.treesitter' end
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'kyazdani42/nvim-tree.lua',
        config = "require'addons.tree'",
    }
    use {
        'neovim/nvim-lspconfig',
        config = function ()
            require 'lang.lsp'
            require 'lang.lsp_common'
            require 'lang.lua'
            require 'lang.yamlls'
        end
    }
    --use 'kabouzeid/nvim-lspinstall'
    --use 'nvim-lua/lsp-status.nvim'
    --use 'nvim-lua/lsp_extensions.nvim'

    use {
        'rmagatti/auto-session',
        config = "require'addons.auto-session'"
    }
    --use 'thaerkh/vim-workspace'

    --use 'puremourning/vimspector'
    use {
        "mfussenegger/nvim-dap",
        config = function ()
            require 'lang.dap'
            require 'lang.dap_common'
        end
    }
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use {'theHamsta/nvim-dap-virtual-text', requires = {"mfussenegger/nvim-dap"} }

    use 'nanotee/sqls.nvim'
    use 'chr4/nginx.vim'
    --use 'keith/swift.vim'

    if vim.g.nvim_preset ~= 'core' then
        use 'rafcamlet/nvim-luapad'
    end
    --use 'johngrib/vim-game-snake'
end)


_G.filter_files = function (path, pattern)
    local files = vim.fn.split(vim.fn.globpath(path, pattern), '\n')
    local index = 0
    local count = #files
    return function ()
        index = index + 1
        if index <= count then
            return files[index]
        end
    end
end

if not vim.g.bootstrap then
    for f in filter_files(vim.g.config_root .. '/config', '*.lua') do
        vim.cmd('luafile ' .. f)
    end
end
