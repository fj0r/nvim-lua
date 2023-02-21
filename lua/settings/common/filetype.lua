vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    command = [[setlocal indentkeys-=<:> indentkeys-=:]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    command = [[setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=0- indentkeys-=<:> indentkeys-=:]]
})

vim.g.plugin_filetypes = {
    'TelescopePrompt',
    'Trouble',
    'help',
    'WhichKey',
    'neo-tree',
    'NeogitCommitView',
    'NeogitStatus',
    'OverseerList',
    'Outline',
    'aerial',
    'lazy',
    'lspinfo',
    'Mundo',
}
