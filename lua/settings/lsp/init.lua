local c = require 'settings.lsp.common'
require 'settings.lsp.ui'

require 'settings.lsp.base'
--require 'settings.lsp.ai'

require 'settings.lang.rust.lsp'
require 'settings.lang.python.lsp'
require 'settings.lang.lua.lsp'
require 'settings.lang.yaml.lsp'
require 'settings.lang.js.lsp'
require 'settings.lang.php.lsp'

if vim.g.nvim_level >= 3 then
    require 'settings.lang.sql.lsp'
    --require 'settings.lang.helm.lsp'
    --require 'settings.lang.typst.lsp'
end

return c
