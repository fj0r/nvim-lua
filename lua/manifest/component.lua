local h = require('lazy_helper')

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
        keys = {
            { '<leader>p', 'pickers', desc = 'telescope pickers' },
            { '<leader>y', 'lsp_document_symbols', desc = 'telescope lsp_document_symbols' },
            { '<leader>m', 'marks', desc = 'telescope marks' },
            { '<leader>d', 'oldfiles', desc = 'telescope oldfiles' },
            { '<leader>f', 'find_files', desc = 'telescope find_files' },
            { '<leader>r', 'live_grep', desc = 'telescope live_grep' },
            { '<leader>T', 'tabs', desc = 'telescope tabs' },
            { '<leader>F', 'git_files', desc = 'telescope git_files' },
            { '<leader>gc', 'git_commits', desc = 'telescope git_commits' },
            { '<leader>gB', 'git_branches', desc = 'telescope git_branches' },
            --{ '<leader>gS', 'git_status', desc = 'telescope git_status' },
            { '<leader>go', 'git_bcommits', desc = 'telescope git_bcommits' },
            { '<leader>b', 'buffers', desc = 'telescope buffers' },
            { '<leader>[', 'builtin', desc = 'telescope builtin' },
            { '<leader>]', 'help_tags', desc = 'telescope help_tags' },
        },
        config = function(plugin)
            local m = require 'plugins.telescope'
            h.apply_keymap(plugin, { fns = m })
        end,
    },
    'TC72/telescope-tele-tabby.nvim',
    'xiyaowong/telescope-emoji.nvim',
    "LinArcX/telescope-env.nvim",

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
        keys = {
            { '<leader>e', ':Neotree reveal<CR>', desc = 'Neotree' }
        },
        config = h.plugins 'neotree',
    },

    {
        's1n7ax/nvim-window-picker',
        keys = {
            { '<M-w>', nil, desc = 'window picker' },
        },
        module = { 'neo-tree' },
        version = 'v1.*',
        config = function(plugin)
            local m = require 'plugins.window-picker'
            local o = { silent = true, noremap = true }
            for _, k in ipairs(plugin.keys) do
                vim.keymap.set('n', k[1], m.pick_win, o)
                vim.keymap.set('i', k[1], m.pick_win, o)
                vim.keymap.set('t', k[1], m.pick_win, o)
            end
        end,
    },

    {
        'sindrets/winshift.nvim',
        keys = {
            { '<leader>ws', '<cmd>WinShift swap<cr>', desc = 'winshift' },
            { '<leader>wx', '<cmd>WinShift<cr>', desc = 'winswap' },
        },
        config = h.plugins 'winshift',
    },

    {
        'simnalamburt/vim-mundo',
        keys = { { '<leader>u', '<cmd>MundoToggle<CR>', desc = 'mundo' } },
    },

    {
        'tversteeg/registers.nvim',
        opts = {},
    },
    {
        'gbprod/yanky.nvim',
        enabled = false,
        opts = {},
    },
}
