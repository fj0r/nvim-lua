require('setup').option_table {
    compatible     = false,
    shortmess      = 'aoOtTWAIcF',

    errorbells     = true,
    visualbell     = true,
    laststatus     = 2,
    showtabline    = 1,
    cmdheight      = 0,
    timeoutlen     = 500,
    wildmenu       = false,

    confirm        = true,
    foldlevel      = 9,
    -- virtualedit  = 'onemore'

    number         = true,
    relativenumber = true,
    ruler          = false,
    showmatch      = true,
    showcmd        = false,

    clipboard      = { 'unnamedplus' },
    display        = { 'lastline' }, -- Always try to show a paragraph’s last line.
    linebreak      = true,           -- Avoid wrapping a line in the middle of a word.
    scrolloff      = 0,              -- The number of screen lines to keep above and below the cursor.
    sidescrolloff  = 0,              -- The number of screen columns to keep to the left and right of the cursor.
    wrap           = true,           -- Enable line wrapping.
    -- ambiwidth    = 'double',       -- 设置为双字宽显示，否则无法完整显示如:☆ :FIXME:
    -- backspace   = 'indent,eol,start',

    encoding       = 'utf-8',
    fileencoding   = 'utf-8',
    fileformat     = 'unix',
    fixendofline   = false,

    hlsearch       = true, -- 搜索时高亮显示被找到的文本
    ignorecase     = true, -- 搜索时忽略大小写
    smartcase      = true, -- 有一个或以上大写字母时仍保持对大小写敏感
    incsearch      = true, -- 输入搜索内容时就显示搜索结果

    magic          = true,
    autoread       = true,
    wildignore     = { '*.pyc', 'node_modules', '*.swp', '*.o', '*.obj' },

    ----- ident
    expandtab      = true,
    tabstop        = 4,
    shiftwidth     = 4,
    softtabstop    = -1,
    autoindent     = true,
    copyindent     = true,
    preserveindent = true,
    breakindent    = true,

    ------ visual
    cursorline     = true,
    cursorcolumn   = false,
    updatetime     = 750,
    lazyredraw     = true, -- "Don’t update screen during macro and script execution.
}


-- cmdheight=0: show recording indicator for macros
if vim.o.cmdheight == 0 then
    vim.api.nvim_create_autocmd("RecordingEnter", { command = 'set cmdheight=1' })
    vim.api.nvim_create_autocmd("RecordingLeave", { command = 'set cmdheight=0' })
end


if os.getenv('NVIM_INS_NOCURSORLINE') == '1' then
    local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
    vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
        pattern = "*",
        command = "set cursorline",
        group = cursorGrp
    })
    vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
        pattern = "*",
        command = "set nocursorline",
        group = cursorGrp
    })
end

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
local yankGrp    = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})

-- auto w/wall
--[=[
vim.api.nvim_create_autocmd({'InsertLeave', 'BufLeave', 'FocusLost'}, {
    command = [[silent! w]]
})
--]=]

