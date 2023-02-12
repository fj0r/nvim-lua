local dirs = { 'backup', 'swap', 'undo', 'info', 'sessions' }

if vim.fn.isdirectory(vim.g.data_root) == 0 then
    os.execute('mkdir -p ' .. vim.g.data_root)
    for _, v in pairs(dirs) do
        local d = vim.g.data_root .. '/' .. v
        if vim.fn.isdirectory(d) == 0 then
            os.execute('mkdir -p ' .. d)
        end
    end
end


local o       = vim.o
o.backup      = true
o.backupdir   = vim.g.data_root .. '/backup/'
o.backupext   = '-vimbackup'
o.backupskip  = ''

o.directory   = vim.g.data_root .. '/swap//'
o.updatecount = 100

o.undofile    = true
o.undodir     = vim.g.data_root .. '/undo/'

o.viminfo     = "'1000,n" .. vim.g.data_root .. "/info/viminfo"
