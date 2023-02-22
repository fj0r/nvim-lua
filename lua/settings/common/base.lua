local o          = vim.o
local opt        = vim.opt
local g          = vim.g
local a          = vim.api

o.compatible     = false
o.shortmess      = 'aoOtTWAIcF'

o.errorbells     = true
o.visualbell     = true
o.laststatus     = 2
o.showtabline    = 1
o.cmdheight      = 0
o.timeoutlen     = 500
o.wildmenu       = false

o.confirm        = true
o.foldlevel      = 9
--o.virtualedit           = 'onemore'

o.number         = true
o.relativenumber = true
o.ruler          = false
o.showmatch      = true
o.showcmd        = false


opt.display:append { 'lastline' } -- Always try to show a paragraph’s last line.
o.linebreak     = true -- Avoid wrapping a line in the middle of a word.
o.scrolloff     = 1 -- The number of screen lines to keep above and below the cursor.
o.sidescrolloff = 5 -- The number of screen columns to keep to the left and right of the cursor.
o.wrap          = true -- Enable line wrapping.

--o.ambiwidth           = 'double' -- 设置为双字宽显示，否则无法完整显示如:☆ :FIXME:
o.backspace     = '2' -- 解决 backspace 按键删除的问题 http://cenalulu.github.io/linux/why-my-backspace-not-work-in-vim/
-- o.backspace          = 'indent,eol,start'
o.encoding      = 'utf-8'
o.fileencoding  = 'utf-8'
o.fileformat    = 'unix'
o.fixendofline  = false

o.hlsearch      = true -- 搜索时高亮显示被找到的文本
o.ignorecase    = true -- 搜索时忽略大小写，
o.smartcase     = true --有一个或以上大写字母时仍保持对大小写敏感
o.incsearch     = true -- 输入搜索内容时就显示搜索结果

o.magic         = true
o.autoread      = true
opt.wildignore:append { '*.pyc', 'node_modules', '*.swp', '*.o', '*.obj' }

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
o.cursorcolumn   = false
o.updatetime     = 750
o.lazyredraw     = true -- "Don’t update screen during macro and script execution.
opt.guicursor:append { 'a:blinkon0' }

if os.getenv('VIM_INS_NOCURSORLINE') == '1' then
    local cursorGrp = a.nvim_create_augroup("CursorLine", { clear = true })
    a.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
        pattern = "*",
        command = "set cursorline",
        group = cursorGrp
    })
    a.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
        pattern = "*",
        command = "set nocursorline",
        group = cursorGrp
    })
end

-- Change preview window location
g.splitbelow = true

-- Highlight on yank
local yankGrp = a.nvim_create_augroup("YankHighlight", { clear = true })
a.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- go to last loc when opening a buffer
a.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})
