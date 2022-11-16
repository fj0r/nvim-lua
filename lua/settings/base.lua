local o          = vim.o
local g          = vim.g
local a          = vim.api
local c          = vim.api.nvim_command
local ex         = vim.api.nvim_exec

o.compatible     = false
o.shortmess      = 'aoOtTWAIcF'

o.errorbells     = true
o.visualbell     = true
o.laststatus     = 2
o.showtabline    = 1
o.cmdheight      = 0
o.wildmenu       = false

o.confirm        = true
o.foldlevel      = 9
o.virtualedit    = 'block'

o.number         = true
o.relativenumber = true
o.ruler          = false
o.showmatch      = true
o.showcmd        = false


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

o.cursorcolumn   = false
o.lazyredraw     = true -- "Don’t update screen during macro and script execution.
o.guicursor      = o.guicursor .. ',a:blinkon0'

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

-- Highlight redundant space
a.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    nested = true,
    callback = function ()
        c [[highlight ExtraWhitespace ctermbg=red guibg=red]]
    end
})
a.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function (ctx)
        local name = vim.api.nvim_buf_get_name(ctx.buf)
        --local ft = vim.bo[ctx.buf].filetype
        --if ft == 'gitcommit' then return end
        if name == '' then return end
        if string.sub(name, 1, 7) == 'term://' then return end
        c [[match ExtraWhitespace /\s\+$\| \+\ze\t/]]
    end
})
a.nvim_create_autocmd("BufWinLeave", {
    pattern = "*",
    command = [[call clearmatches()]]
})

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
