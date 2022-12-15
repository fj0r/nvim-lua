local a   = vim.api
local m   = vim.api.nvim_set_keymap
local c   = vim.api.nvim_command
local u   = vim.api.nvim_create_user_command
local g   = vim.g
local ex  = vim.api.nvim_exec
local op1 = { noremap = true }
local op2 = { noremap = true, silent = true }
local op3 = { noremap = true, expr = true, silent = true }

m('', '<Space>', '<Nop>', op2)
g.mapesc = '<C-;>'
g.mapleader = " "
g.maplocalleader = " "

m('i', g.mapesc, '<ESC>', op2)
m('c', g.mapesc, '<ESC>', op2)
m('v', g.mapesc, '<ESC>', op2)
m('t', g.mapesc, '<C-\\><C-n>', op2)

-- map kj to <ESC>, 150ms interval
if os.getenv('VIM_DUAL_ESC') == '1' then
    m('i', 'kj', '<ESC>', op2)
    c('autocmd InsertEnter * set timeoutlen=150')
    c('autocmd InsertLeave * set timeoutlen=1000')
end

if os.getenv('VIM_JK_WRAP') == '1' then
    m('n', 'k', "v:count == 0 ? 'gk' : 'k'", op3)
    m('n', 'j', "v:count == 0 ? 'gj' : 'j'", op3)
    m('v', 'k', "v:count == 0 ? 'gk' : 'k'", op3)
    m('v', 'j', "v:count == 0 ? 'gj' : 'j'", op3)
end

-- go to end of parenthesis/brackets/quotes without switching insert mode
--[[ provided by vim-rsi
m('i', '<C-l>', '<C-o>A', op2)
m('i', '<C-a>', '<C-o>^', op2)
m('i', '<C-e>', '<C-o>$', op2)
m('i', '<C-f>', '<C-o>l', op2)
m('i', '<C-b>', '<C-o>h', op2)
m('i', '<M-f>', '<C-o>w', op2)
m('i', '<M-b>', '<C-o>b', op2)
m('i', '<C-w>', '<C-o>db', op2)

m('c', '<C-o>', '<C-f>', op1)
m('c', '<C-a>', '<Home>', op1)
m('c', '<C-e>', '<End>', op1)
m('c', '<C-f>', '<Right>', op1)
m('c', '<C-b>', '<Left>', op1)
m('c', '<M-f>', '<S-Right>', op1)
m('c', '<M-b>', '<S-Left>', op1)
m('c', '<C-d>', '<Delete>', op1)
--]]
m('c', '<M-o>', '<C-f>', op1)

-- Go to home and end using capitalized directions
m('n', 'H', '^', op2)
m('n', 'L', '$', op2)

-- visual selection excluding newline & space
m('x', 'H', '^', op2)
m('x', 'L', 'g_', op2)

-- 去掉搜索高亮
m('n', '<leader>/', ':nohls<CR>', op2)
m('n', '<C-/>', ':nohls<CR>', op2)
-- command history
m('n', '<leader>;', ':<C-f>', op2)
-- NOTE: not need
-- m('n', '<leader>p', '<cmd>set paste!<CR>', op2)

m('n', 'M', '<cmd>marks<CR>', op2)

m('n', '<leader>q', '<cmd>quit<CR>', op2)

local kill_tabpage = function ()
    local t = vim.api.nvim_get_current_tabpage()
    local w = vim.api.nvim_tabpage_list_wins(t)
    for _, b in pairs(w) do
        vim.api.nvim_buf_delete(vim.api.nvim_win_get_buf(b), {force=true})
    end
end
u('Q', kill_tabpage, {desc = 'close all window of the current tabpage'})
m('n', '<M-q>', '', { callback = kill_tabpage, noremap = true, silent = true })
m('i', '<M-q>', '', { callback = kill_tabpage, noremap = true, silent = true })
m('t', '<M-q>', '', { callback = kill_tabpage, noremap = true, silent = true })

c('command! -nargs=0  W :wall')
c('command! -nargs=0  Wq :wall|tabclose')
c('command! -nargs=0  WQ :wqall')
-- reload file
c('command! -nargs=0  E :e!')


ex([[
nnoremap <expr><silent><Esc> len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) ? ":ccl<CR>" : "\<Esc>"
"快速编辑自定义宏
nnoremap <leader>xm  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
]], false)


-- 防止水平滑动的时候失去选择
m('x', '<', '<gv', op2)
m('x', '>', '>gv', op2)

-- toggle number
m('n', '<leader>n', '<cmd>set relativenumber! | :set number!<CR>', op2)

-- Y yank until the end of line
m('n', 'Y', 'y$', op2)


-- windows to close with "q"
a.nvim_create_autocmd("FileType", {
    pattern = { "help", "startuptime", "qf", "lspinfo" },
    command = [[nnoremap <buffer><silent> q :close<CR>]]
})
a.nvim_create_autocmd("FileType", {
    pattern = "man",
    command = [[nnoremap <buffer><silent> q :quit<CR>]]
})
