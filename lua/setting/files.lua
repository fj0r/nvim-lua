local base    = os.getenv('HOME') .. '/.vim.files'
local dirs    = { 'backup', 'swap', 'undo', 'info', 'sessions'}

if vim.fn.isdirectory(base) == 0 then
    os.execute('mkdir -p ' .. base)
    for _, v in pairs(dirs) do
        local d = base..'/'..v
        if vim.fn.isdirectory(d) == 0 then
            os.execute('mkdir -p ' .. d)
        end
    end
end


local o       = vim.o
o.backup      = true
o.backupdir   = base..'/backup/'
o.backupext   = '-vimbackup'
o.backupskip  = ''

o.directory   = base..'/swap//'
o.updatecount = 100

o.undofile    = true
o.undodir     = base..'/undo/'

o.viminfo     = "'1000,n$HOME/.vim.files/info/viminfo"
