if vim.g.nvim_level >= 2 then
    require 'settings.lsp.common'
    require 'settings.lsp.ui'

    require 'settings.lsp.base'

    --require 'settings.lang.python.lsp'
    require 'settings.lang.lua.lsp'
    require 'settings.lang.yaml.lsp'
    require 'settings.lang.js.lsp'
    require 'settings.lang.php.lsp'
end

if vim.g.nvim_level >= 3 then
    require 'settings.lang.sql.lsp'
    --require 'settings.lang.helm.lsp'
    require 'settings.lang.typst.lsp'
end
