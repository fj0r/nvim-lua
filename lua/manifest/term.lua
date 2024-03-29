-- [Moving cursor forces user out of terminal mode](https://github.com/neovide/neovide/issues/1838)
vim.keymap.set("t", "<MouseMove>", "<NOP>")

local m = require('setup').mod

return {
    {
        'chomosuke/term-edit.nvim',
        lazy = false, -- or ft = 'toggleterm' if you use toggleterm.nvim
        version = '1.*',
        enabled = false,
        config = function()
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
            { m 'x',        nil, desc = 'toggle taberm' },
            { m 'y',        nil, desc = 'paste',         mode = 't' },
            { '<leader>xx', nil, desc = 'tab' },
            { '<leader>xv', nil, desc = 'vertical' },
            { '<leader>xV', nil, desc = 'vertical_ext' },
            { '<leader>xc', nil, desc = 'horizontal' },
            { '<leader>xC', nil, desc = 'horizontal_ext' },
        },
        opts = {
            keymap = {
                toggle = m 'x',
                paste = m 'y',
                normal = m '\\',
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
