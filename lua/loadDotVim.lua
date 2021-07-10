local U = require 'utils'
for f in U.filter_files(vim.g.config_root..'/config', '*.vim') do
    vim.cmd('so ' .. f)
end

