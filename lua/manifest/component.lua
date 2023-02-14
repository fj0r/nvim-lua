return {
    {
        'nvim-telescope/telescope.nvim',
        config = function(plugin) require 'plugins.telescope' end,
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
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
        keys = { { '<leader>e', nil, desc = 'Neotree' } },
        config = function(plugin) require 'plugins.neotree' end,
    },

    {
        's1n7ax/nvim-window-picker',
        keys = {
            { '<leader>ww', nil, desc = 'window picker' },
            { '<M-w>',      nil, desc = 'window picker' },
        },
        module = { 'neo-tree' },
        version = 'v1.*',
        config = function(plugin) require 'plugins.window-picker' end,
    },

    {
        'sindrets/winshift.nvim',
        keys = {
            { '<leader>ws', nil, desc = 'winshift' },
            { '<leader>wx', nil, desc = 'winswap' },
        },
        config = function(plugin) require 'plugins.winshift' end,
    },

    {
        'simnalamburt/vim-mundo',
        keys = { { '<leader>u', '<cmd>MundoToggle<CR>', desc = 'mundo' } },
    },

    {
        'tversteeg/registers.nvim',
        config = function(plugin) require 'registers'.setup() end
    },
    {
        'gbprod/yanky.nvim',
        enabled = false,
        config = function (plugin) require 'yanky'.setup() end
    },
}
