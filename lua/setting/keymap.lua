vim.g.mapleader = " "

--插入模式下 jk/kj 映射为 ESC，两次按键间隔不能超过 150毫秒
if os.getenv('VIM_DUAL_ESC') == '1' then
    vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true})
    vim.api.nvim_command('autocmd InsertEnter * set timeoutlen=150')
    vim.api.nvim_command('autocmd InsertLeave * set timeoutlen=1000')
end

local m = vim.api.nvim_set_keymap
local c = vim.api.nvim_command
local opt = { noremap = true }

-- go to end of parenthesis/brackets/quotes without switching insert mode
m('i', '<C-e>', '<C-o>A', opt)
m('i', '<C-f>', '<C-o>a', opt)
m('i', '<C-b>', '<C-o>h', opt)

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

m('c', '<C-a>', '<Home>', opt)
m('c', '<C-e>', '<End>', opt)
m('c', '<M-f>', '<C-Right>', opt)
m('c', '<M-b>', '<C-Left>', opt)



-- 去掉搜索高亮
m('n', '<leader>/', '<cmd>nohls<CR>', {noremap=true, silent=true})
-- command history
m('n', '<leader>;', ':<C-f>', {noremap=true, silent=true})
-- NOTE: not need
m('n', '<leader>p', '<cmd>set paste!<CR>', {noremap=true, silent=true})

m('n', 'M', '<cmd>marks<CR>', opt)
-- Quickly close the current window
m('n', '<leader>q', '<cmd>q<CR>', opt)
-- Quickly save the current file
m('n', '<leader>w', '<cmd>w<CR>', opt)
c('command! -nargs=0  W :wall')
-- reload file
c('command! -nargs=0  E :e!')


vim.api.nvim_exec([[
nnoremap <expr><silent><Esc> len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) ? ":ccl<CR>" : "\<Esc>"
"快速编辑自定义宏
nnoremap <leader>xm  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
]], false)


-- 防止水平滑动的时候失去选择
m('x', '<', '<gv', opt)
m('x', '>', '>gv', opt)

m('n', '<leader>n', '<cmd>set relativenumber! | :set number!<CR>', {noremap=true, silent=true})
