require 'other.translate'

return {
    -- use_rocks 'lua-yaml'

    --[=[
    'tpope/vim-speeddating',
    {
        'monaqa/dial.nvim',
        config = function(plugin) require'plugins.dial' end
    },
    --]=]

    {
        'jbyuki/instant.nvim',
        cmd = { 'InstantStartSingle', 'InstantStartSession', 'InstantStartServer' },
        enabled = vim.g.nvim_level >= 3,
    },
}
