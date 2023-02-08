return {
    {
        'LhKipp/nvim-nu',
        enabled = false,
        build = ':TSInstall nu',
        config = function(plugin) require'nu'.setup{} end
    },
    {
        'nvim-orgmode/orgmode',
        keys = {
            {'<leader>oa', nil, desc = 'orgmode agenda'},
            {'<leader>oc', nil, desc = 'orgmode capture'},
        },
        ft = {'org'},
        config = function(plugin) require'plugins.orgmode' end,
    },
    {
        'NTBBloodbath/rest.nvim',
        keys = {{'<leader>h', nil, desc = 'rest'}},
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(plugin) require'plugins.rest' end,
    },
    {
        'rafcamlet/nvim-luapad',
        enabled = vim.g.nvim_preset ~= 'core',
        cmd = { 'Luapad', 'LuaRun' },
    },
}
