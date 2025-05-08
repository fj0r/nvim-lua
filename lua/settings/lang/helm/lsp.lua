local util = require('lspconfig.util')

vim.lsp.config('helm_ls', {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm" },
    root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
    end,
})

vim.lsp.enable('helm_ls')
