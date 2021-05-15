--[[
" 确保目录存在
let s:filesdir = $HOME . '/.vim.files'
if !isdirectory(s:filesdir) && exists('*mkdir')
  call mkdir(s:filesdir)
endif

if exists('*mkdir')
  for dir in ['backup', 'swap', 'undo', 'info']
    let s:d = s:filesdir . '/' . dir
    if !isdirectory(s:d)
      call mkdir(s:d)
    endif
  endfor
endif

set backup
set backupdir   =$HOME/.vim.files/backup/
set backupext   =-vimbackup
set backupskip  =

set directory   =$HOME/.vim.files/swap//
set updatecount =100

set undofile
set undodir     =$HOME/.vim.files/undo/

set viminfo     ='1000,n$HOME/.vim.files/info/viminfo
]]
