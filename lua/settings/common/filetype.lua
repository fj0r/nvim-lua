vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    command = [[setlocal indentkeys-=<:> indentkeys-=:]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    command = [[setlocal ts=4 sts=4 sw=4 expandtab indentkeys-=0# indentkeys-=0- indentkeys-=<:> indentkeys-=:]]
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
