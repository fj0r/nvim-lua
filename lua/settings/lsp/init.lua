require 'settings.lsp.common'
require 'settings.lsp.ui'

require 'settings.lsp.base'

require 'settings.lang.lua.lsp'
require 'settings.lang.yaml.lsp'
require 'settings.lang.js.lsp'
require 'settings.lang.php.lsp'

if vim.g.nvim_preset ~= 'core' then
    require 'settings.lang.sql.lsp'
    require 'settings.lang.docker.lsp'
    require 'settings.lang.helm.lsp'
end
