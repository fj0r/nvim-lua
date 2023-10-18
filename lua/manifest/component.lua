local h = require('lazy_helper')

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
        keys = {
            { '<leader>p', 'pickers', desc = 'telescope pickers' },
            { '<leader>y', 'lsp_document_symbols', desc = 'telescope lsp_document_symbols' },
            { '<leader>m', 'marks', desc = 'telescope marks' },
            { '<leader>c', 'registers', desc = 'telescope registers' },
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
            { '<leader>N', 'notify', desc = 'telescope notify' },
        },
        config = h.plugins 'telescope',
        enabled = vim.g.nvim_level >= 2
    },
    {
        'TC72/telescope-tele-tabby.nvim',
        enabled = vim.g.nvim_level >= 2
    },
    {
        'xiyaowong/telescope-emoji.nvim',
        enabled = vim.g.nvim_level >= 2
    },
    {
        "LinArcX/telescope-env.nvim",
        enabled = vim.g.nvim_level >= 2
    },


    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v3.x",
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
            { '<leader>e', 'reveal', desc = 'Neotree' }
        },
        config = h.plugins 'neotree',
        enabled = vim.g.nvim_level >= 2
    },

    {
        's1n7ax/nvim-window-picker',
        keys = {
            { '<leader>ww', 'pick_win', desc = 'window picker' },
            { '<M-w>', 'pick_win', desc = 'window picker', mode = { 'n', 'v', 'i', 't' } },
        },
        module = { 'neo-tree' },
        version = 'v1.*',
        config = h.plugins 'window-picker',
        enabled = vim.g.nvim_level >= 2
    },

    {
        'sindrets/winshift.nvim',
        keys = {
            { '<leader>ws', '<cmd>WinShift swap<cr>', desc = 'winshift' },
            { '<leader>wx', '<cmd>WinShift<cr>', desc = 'winswap' },
        },
        config = h.plugins 'winshift',
        enabled = vim.g.nvim_level >= 2
    },

    {
        'simnalamburt/vim-mundo',
        keys = { { '<leader>u', '<cmd>MundoToggle<CR>', desc = 'mundo' } },
        enabled = false,
    },

    {
        'tversteeg/registers.nvim',
        enabled = false,
        opts = {},
    },
    {
        'gbprod/yanky.nvim',
        enabled = false,
        opts = {},
    },
}
