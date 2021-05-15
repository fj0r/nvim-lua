for f in filter_files(vim.g.config_root..'/config', '*.vim') do
    vim.cmd('so ' .. f)
end

