local o          = vim.o
local g          = vim.g
local c          = vim.api.nvim_command
local ex         = vim.api.nvim_exec

o.compatible     = false
o.shortmess      = 'aoOtTWAIcqF'

o.errorbells     = false
o.visualbell     = false
o.laststatus     = 2
o.wildmenu       = true

o.confirm        = true
o.foldlevel      = 9
o.virtualedit    = 'block'

o.number         = true
o.relativenumber = true
o.ruler          = true
o.showmatch      = true -- 显示匹配的括号
o.showcmd        = true -- 输入命令回显

-- c 'syntax on' -- 自动语法高亮

o.display        = o.display .. ',lastline' -- Always try to show a paragraph’s last line.
o.linebreak      = true -- Avoid wrapping a line in the middle of a word.
o.scrolloff      = 1 -- The number of screen lines to keep above and below the cursor.
o.sidescrolloff  = 5 -- The number of screen columns to keep to the left and right of the cursor.
o.wrap           = true -- Enable line wrapping.

--o.ambiwidth    = 'double' -- 设置为双字宽显示，否则无法完整显示如:☆ :FIXME:
o.backspace      = '2' -- 解决 backspace 按键删除的问题 http://cenalulu.github.io/linux/why-my-backspace-not-work-in-vim/
-- o.backspace   = 'indent,eol,start'
o.encoding       = 'utf-8'
o.fileencoding   = 'utf-8'
o.fileformat     = 'unix'
o.fixendofline   = false

o.hlsearch       = true -- 搜索时高亮显示被找到的文本
o.ignorecase     = true -- 搜索时忽略大小写，
o.smartcase      = true --有一个或以上大写字母时仍保持对大小写敏感
o.incsearch      = true -- 输入搜索内容时就显示搜索结果

o.magic          = true
o.autoread       = true
o.wildignore     = o.wildignore .. ',.pyc,.swp'

----- ident
o.expandtab      = true
o.tabstop        = 4
o.shiftwidth     = 4
o.softtabstop    = -1
o.autoindent     = true
o.copyindent     = true
o.preserveindent = true
o.breakindent    = true

------ visual
o.cursorline     = true
c 'autocmd InsertLeave,WinEnter * set cursorline'
c 'autocmd InsertEnter,WinLeave * set nocursorline'
o.cursorcolumn   = false
o.lazyredraw     = true -- "Don’t update screen during macro and script execution.
o.guicursor      = o.guicursor .. ',a:blinkon0'

-- 高亮冗余空格 :NOTE:
c [[highlight ExtraWhitespace ctermbg=red guibg=red]]
c [[match ExtraWhitespace /\s\+$\| \+\ze\t/]]

-- Change preview window location
g.splitbelow = true

-- Highlight on yank
ex([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- cmdheight
local v = vim.version()
if v.major >= 0 and v.minor >= 8 then
    o.cmdheight = 0
end
