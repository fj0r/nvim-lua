vim.lsp.config('rust_analyzer', {
    settings = {
      ['rust-analyzer'] = {
        completion = {
          autoimport = {
            enable = false,
          },
        },
      },
    }
})

vim.lsp.enable('rust_analyzer')
