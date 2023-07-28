local dirs = { 'backup', 'swap', 'undo', 'info', 'sessions' }

if vim.fn.isdirectory(vim.g.data_root) == 0 then
    os.execute('mkdir -p ' .. vim.g.data_root)
    for _, v in ipairs(dirs) do
        local d = vim.g.data_root .. '/' .. v
        if vim.fn.isdirectory(d) == 0 then
            os.execute('mkdir -p ' .. d)
        end
    end
end


require('helper').option_table {
    backup      = true,
    backupdir   = vim.g.data_root .. '/backup/',
    backupext   = '-vimbackup',
    backupskip  = '',

    directory   = vim.g.data_root .. '/swap//',
    updatecount = 100,

    undofile    = true,
    undodir     = vim.g.data_root .. '/undo/',

    viminfo     = "'1000,n" .. vim.g.data_root .. "/info/viminfo",
}
