"插入模式下 jk/kj 映射为 ESC，两次按键间隔不能超过 150毫秒
if $VIM_DUAL_ESC
  "inoremap jk <ESC>
  inoremap kj <ESC>
  autocmd InsertEnter * set timeoutlen=150
  autocmd InsertLeave * set timeoutlen=1000
endif

"go to end of parenthesis/brackets/quotes without switching insert mode
inoremap <C-e> <C-o>A
inoremap <C-f> <C-o>a
inoremap <C-b> <C-o>h

" j k 在屏幕行间上下移动；gj gk 在物理行间上下移动
"noremap j gj
"noremap k gk
"noremap gj j
"noremap gk k

" move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-W><C-j> <C-W><S-j>
nnoremap <C-W><C-k> <C-W><S-k>
nnoremap <C-W><C-h> <C-W><S-h>
nnoremap <C-W><C-l> <C-W><S-l>
command! -nargs=1 VR :vertical resize <args>
command! -nargs=1 HR :resize <args>

" move between tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

command! -complete=file -nargs=? T :tabnew <args>

" Go to home and end using capitalized directions
nnoremap H ^
nnoremap L $

" visual selection excluding newline & space
xnoremap H ^
xnoremap L g_

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-f> <C-Right>
cnoremap <M-b> <C-Left>

" 去掉搜索高亮
nnoremap <silent><leader>/ :nohls<CR>
" NOTE:
nnoremap <silent><leader>p :set paste!<CR>

nnoremap M :marks<CR>
" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>
command! -nargs=0  W :wall
" reload file
command! -nargs=0  E :e!

nnoremap <expr><silent><Esc>
    \ len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))
    \ ? ":ccl<CR>" : "\<Esc>"

" 快速编辑自定义宏
nnoremap <leader>xm  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" 防止水平滑动的时候失去选择
xnoremap < <gv
xnoremap > >gv

nnoremap <silent><leader>n :set relativenumber! \| :set number!<CR>
