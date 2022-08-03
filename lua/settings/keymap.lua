local m   = vim.api.nvim_set_keymap
local c   = vim.api.nvim_command
local g   = vim.g
local ex  = vim.api.nvim_exec
local opn = { noremap = true }
local opt = { noremap = true, silent = true }
local ope = { noremap = true, expr = true, silent = true }

m('', '<Space>', '<Nop>', opt)
g.mapleader = " "
g.maplocalleader = " "

--插入模式下 jk/kj 映射为 ESC，两次按键间隔不能超过 150毫秒
if os.getenv('VIM_DUAL_ESC') == '1' then
    m('i', 'kj', '<ESC>', opt)
    c('autocmd InsertEnter * set timeoutlen=150')
    c('autocmd InsertLeave * set timeoutlen=1000')
end

if os.getenv('VIM_JK_WRAP') == '1' then
    m('n', 'k', "v:count == 0 ? 'gk' : 'k'", ope)
    m('n', 'j', "v:count == 0 ? 'gj' : 'j'", ope)
    m('v', 'k', "v:count == 0 ? 'gk' : 'k'", ope)
    m('v', 'j', "v:count == 0 ? 'gj' : 'j'", ope)
end

-- go to end of parenthesis/brackets/quotes without switching insert mode
m('i', '<C-l>', '<C-o>A', opt)
m('i', '<C-a>', '<C-o>^', opt)
m('i', '<C-e>', '<C-o>$', opt)
m('i', '<C-f>', '<C-o>l', opt)
m('i', '<C-b>', '<C-o>h', opt)
m('i', '<M-f>', '<C-o>w', opt)
m('i', '<M-b>', '<C-o>b', opt)
m('i', '<C-w>', '<C-o>db', opt)

m('c', '<M-o>', '<C-f>', opn)
m('c', '<C-a>', '<Home>', opn)
m('c', '<C-e>', '<End>', opn)
m('c', '<C-f>', '<Right>', opn)
m('c', '<C-b>', '<Left>', opn)
m('c', '<M-f>', '<S-Right>', opn)
m('c', '<M-b>', '<S-Left>', opn)
m('c', '<C-d>', '<Delete>', opn)

m('n', '<C-j>', '<C-W>j', opt)
m('n', '<C-k>', '<C-W>k', opt)
m('n', '<C-h>', '<C-W>h', opt)
m('n', '<C-l>', '<C-W>l', opt)
m('n', '<C-W><C-j>', '<C-W><S-j>', opt)
m('n', '<C-W><C-k>', '<C-W><S-k>', opt)
m('n', '<C-W><C-h>', '<C-W><S-h>', opt)
m('n', '<C-W><C-l>', '<C-W><S-l>', opt)
c('command! -nargs=1 VR :vertical resize <args>')
c('command! -nargs=1 HR :resize <args>')

-- move between tabs
m('n', '<leader>1', '1gt', opt)
m('n', '<leader>2', '2gt', opt)
m('n', '<leader>3', '3gt', opt)
m('n', '<leader>4', '4gt', opt)
m('n', '<leader>5', '5gt', opt)
m('n', '<leader>6', '6gt', opt)
m('n', '<leader>7', '7gt', opt)
m('n', '<leader>8', '8gt', opt)
m('n', '<leader>9', '9gt', opt)
m('n', '<leader>0', '<cmd>tablast<cr>', opt)

c('command! -complete=file -nargs=? T :tabnew <args>')


-- Go to home and end using capitalized directions
m('n', 'H', '^', opt)
m('n', 'L', '$', opt)

-- visual selection excluding newline & space
m('x', 'H', '^', opt)
m('x', 'L', 'g_', opt)

-- 去掉搜索高亮
m('n', '<leader>/', ':nohls<CR>', opt)
-- command history
m('n', '<leader>;', ':<C-f>', opt)
-- NOTE: not need
-- m('n', '<leader>p', '<cmd>set paste!<CR>', opt)

m('n', 'M', '<cmd>marks<CR>', opt)
-- Quickly close the current window
m('n', '<leader>q', '<cmd>q<CR>', opt)
c('command! -nargs=0  W :wall')
-- reload file
c('command! -nargs=0  E :e!')


ex([[
nnoremap <expr><silent><Esc> len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) ? ":ccl<CR>" : "\<Esc>"
"快速编辑自定义宏
nnoremap <leader>xm  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
]], false)


-- 防止水平滑动的时候失去选择
m('x', '<', '<gv', opt)
m('x', '>', '>gv', opt)

-- toggle number
m('n', '<leader>n', '<cmd>set relativenumber! | :set number!<CR>', opt)

-- Y yank until the end of line
m('n', 'Y', 'y$', opt)
