vim.lsp.config('helm_ls', {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm" },
    root_dir = function(fname)
        return vim.fs.root(fname, { 'Chart.yaml' })
    end,
})

vim.lsp.enable('helm_ls')
