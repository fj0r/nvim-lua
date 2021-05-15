-- 确保目录存在
vim.api.nvim_exec([[
let b:filesdir = $HOME . '/.vim.files'
if !isdirectory(b:filesdir) && exists('*mkdir')
  call mkdir(b:filesdir)
endif

if exists('*mkdir')
  for dir in ['backup', 'swap', 'undo', 'info']
    let b:d = b:filesdir . '/' . dir
    if !isdirectory(b:d)
      call mkdir(b:d)
    endif
  endfor
endif
]], false)

local o       = vim.o
o.backup      = true
o.backupdir   = vim.fn.getenv('HOME')..'/.vim.files/backup/'
o.backupext   = '-vimbackup'
o.backupskip  = ''

o.directory   = vim.fn.getenv('HOME')..'/.vim.files/swap//'
o.updatecount = 100

o.undofile    = true
o.undodir     = vim.fn.getenv('HOME').. '/.vim.files/undo/'


o.viminfo     = "'1000,n$HOME/.vim.files/info/viminfo"
