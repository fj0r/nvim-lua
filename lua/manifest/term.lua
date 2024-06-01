-- [Moving cursor forces user out of terminal mode](https://github.com/neovide/neovide/issues/1838)
vim.keymap.set("t", "<MouseMove>", "<NOP>")

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
            { '<M-x>',      nil, desc = 'toggle taberm' },
            { '<M-c>',      nil, desc = 'toggle taberm horizontal' },
            { '<M-y>',      nil, desc = 'paste', mode = 't' },
            { '<leader>x', nil, desc = 'tab' },
        },
        opts = {
            keymap = {
                toggle = '<M-[>',
                toggle_h = '<M-]>',
                paste = '<M-y>',
                escape = vim.g.mapesc,
            },
            direct_keys = {
                '<Enter>', '<M-w>', '<C-w>',
                '<C-c>', '<C-d>', '<M-d>',
                '<C-a>', '<C-e>', '<M-a>', '<M-e>',
                '<C-f>', '<C-b>', '<M-f>', '<M-b>',
                '<C-n>', '<C-p>', '<M-n>', '<M-p>',
                '<M-o>', '<M-i>'
            },
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
