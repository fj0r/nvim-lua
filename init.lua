vim.g.config_root = vim.fn.stdpath('config')
vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.g.config_root
vim.g.nvim_preset = vim.fn.exists('$NVIM_PRESET') and os.getenv('NVIM_PRESET') or 'core'
vim.g.bootstrap   = vim.fn.exists('$NVIM_BOOTSTRAP')

-- let g:nvim_preset  = exists('$NVIM_PRESET') ? $NVIM_PRESET: 'core'
-- let g:bootstrap    = exists('$NVIM_BOOTSTRAP')
-- let g:config_root  = expand('<sfile>:p:h')
-- let &rtp          .= ',' . g:config_root
-- let &packpath     .= ',' .. g:config_root

vim.cmd [[packadd packer.nvim]]

local packer = require 'packer'


packer.init {
    package_root = vim.g.config_root .. '/pack'
}

packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'norcalli/nvim.lua'
    use 'norcalli/nvim-base16.lua'
    --use 'rktjmp/lush.nvim'
    use 'norcalli/nvim-colorizer.lua'

    --use 'vim-airline/vim-airline'
    --use 'vim-airline/vim-airline-themes'
    --use 'ompugao/vim-airline-datetime'
    --use 'itchyny/lightline.vim'
    --use 'niklaas/lightline-gitdiff'
    use 'kyazdani42/nvim-web-devicons'
    use {'glepnir/galaxyline.nvim' , branch = 'main'}
    use 't9md/vim-choosewin'

    use 'skywind3000/asyncrun.vim'
    use 'skywind3000/asynctasks.vim'
    use 'GustavoKatel/telescope-asynctasks.nvim'

    use 'akinsho/nvim-toggleterm.lua'
    --use 'skywind3000/vim-terminal-help'
    --use 'kassio/neoterm'

    --use 't9md/vim-smalls'
    use 'justinmk/vim-sneak'
    use 'chaoren/vim-wordmotion'
    --use 'easymotion/vim-easymotion'
    use 'mg979/vim-visual-multi'

    --use 'jiangmiao/auto-pairs'
    use 'windwp/nvim-autopairs'
    use 'junegunn/vim-easy-align'
    use 'Chiel92/vim-autoformat'
    use 'junegunn/rainbow_parentheses.vim'
    use 'tpope/vim-commentary'

    --use 'matze/vim-move'
    use 'wellle/targets.vim'
    --use 'machakann/vim-sandwich'
    use 'tpope/vim-surround'
    use 'machakann/vim-swap'

    use 'hrsh7th/nvim-compe'
    --use 'norcalli/snippets.nvim'
    use 'hrsh7th/vim-vsnip'
    --use 'hrsh7th/vim-vsnip-integ'
    --use 'SirVer/ultisnips'

    --use 'tpope/vim-fugitive'
    use 'TimUntersberger/neogit'
    --use 'mbbill/undotree'
    use 'simnalamburt/vim-mundo'
    --use 'jceb/vim-orgmode'
    --use 'tpope/vim-speeddating'
    use 'jbyuki/instant.nvim'

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'TC72/telescope-tele-tabby.nvim'


    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'kyazdani42/nvim-tree.lua'
    use 'neovim/nvim-lspconfig'
    --use 'kabouzeid/nvim-lspinstall'
    --use 'nvim-lua/lsp-status.nvim'
    --use 'nvim-lua/lsp_extensions.nvim'

    use 'rmagatti/auto-session'
    --use 'thaerkh/vim-workspace'

    --use 'puremourning/vimspector'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    use 'nanotee/sqls.nvim'
    use 'chr4/nginx.vim'
    --use 'keith/swift.vim'
    use 'ojroques/vim-oscyank'

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

if vim.g.bootstrap == 0 then
    for f in filter_files(vim.g.config_root .. '/config', '*.lua') do
        vim.cmd('luafile ' .. f)
    end
end
