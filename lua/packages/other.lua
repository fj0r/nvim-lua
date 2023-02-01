return {
    -- use_rocks 'lua-yaml'



    --[=[
    'tpope/vim-speeddating',
    {
        'monaqa/dial.nvim',
        config = function(plugin) require'extensions.dial' end
    },
    --]=]

    {
        'jbyuki/instant.nvim',
        cmd = {'InstantStartSingle', 'InstantStartSession', 'InstantStartServer'}
        --enabled = vim.g.nvim_preset ~= 'core',
    },


    --[=[
    {
        'kyazdani42/nvim-tree.lua',
        config = function(plugin) require'extensions.tree' end,
    },
    --]=]

    --[=[
    'kabouzeid/nvim-lspinstall',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/lsp_extensions.nvim',

    {
        "olimorris/persisted.nvim",
        config = function(plugin) require'extensions.persisted' end,
    },
    --]=]
}
