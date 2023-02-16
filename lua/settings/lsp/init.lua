require 'settings.lsp.common'
require 'settings.lsp.ui'
require 'settings.lsp.base'
require 'settings.lsp.lua'
require 'settings.lsp.yaml'
require 'settings.lsp.frontend'
require 'settings.lsp.php'
if vim.g.nvim_preset ~= 'core' then
    require 'settings.lsp.sql'
    require 'settings.lsp.docker'
end
