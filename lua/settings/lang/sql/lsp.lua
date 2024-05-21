-- require 'lspconfig'.sqlls.setup {}

require('lspconfig.configs').postgres_lsp = {
  default_config = {
    name = 'postgres_lsp',
    cmd = {'postgres_lsp'},
    filetypes = {'sql'},
    single_file_support = true,
    root_dir = require('lspconfig.util').root_pattern 'root-file.txt'
  }
}
