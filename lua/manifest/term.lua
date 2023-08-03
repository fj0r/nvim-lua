return {
    {
        'chomosuke/term-edit.nvim',
        lazy = false, -- or ft = 'toggleterm' if you use toggleterm.nvim
        version = '1.*',
        config = function ()
            local nu = os.getenv('SHELL') == 'nu'
            require 'term-edit'.setup {
                prompt_end = nu and '% ' or '%$ ',
                feedkeys_delay = nu and 1000 or 10,
            }
        end
    },
    {
        'fj0r/nvim-taberm',
        keys = {
            { '<C-x>', nil, desc = 'taberm' },
        },
        opts = {
            keymap = {
                toggle = '<C-x>'
            }
        },
        enabled = vim.g.nvim_level >= 2,
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
        config = function(plugin) require'plugins.toggleterm' end,
    },
    --]=]
}
