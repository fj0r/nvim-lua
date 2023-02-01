return {
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
        keys = {{'<leader>e', nil, desc = 'Neotree'}},
        config = function(plugin) require'extensions.neotree' end,
    },

    {
        'nvim-telescope/telescope.nvim',
        config = function(plugin) require'extensions.telescope' end,
        dependencies = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    },
    'TC72/telescope-tele-tabby.nvim',
    'xiyaowong/telescope-emoji.nvim',
    "LinArcX/telescope-env.nvim",

    {
        's1n7ax/nvim-window-picker',
        keys = {{'<leader><leader>', nil, desc = 'window picker'}},
        module = { 'neo-tree' },
        version = 'v1.*',
        config = function(plugin) require'extensions.window-picker' end,
    },

    {
        'sindrets/winshift.nvim',
        keys = {
            {'<leader>ws', nil, desc = 'winshift'},
            {'<leader>wx', nil, desc = 'winswap'},
        },
        config = function(plugin) require'extensions.winshift' end,
    },
    {
        'notomo/cmdbuf.nvim',
        enabled = false,
        config = function(plugin) require'extensions.cmdbuf' end,
    },

    {
        "folke/which-key.nvim",
        config = function(plugin) require'extensions.whichkey' end,
    },
    {
        'kevinhwang91/nvim-hlslens',
        config = function(plugin) require'hlslens'.setup() end
    },
}
