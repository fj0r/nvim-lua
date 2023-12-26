vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapesc = nil -- nil or '<C-;>'
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local jk_wrap = os.getenv('NVIM_JK_WRAP') == '1'

require('setup').keymap_table {
    { vim.g.mapesc or '<ESC>', '<C-\\><C-n>',                                 'ns',  mode = 't' },
    { vim.g.mapesc,            '<ESC>',                                       'ns',  mode = 'nicv', disabled = not vim.g.mapesc },
    { vim.g.arrow_keys.k,      "v:count == 0 ? 'gk' : 'k'",                   'nse', mode = 'nv',   disabled = not jk_wrap },
    { vim.g.arrow_keys.j,      "v:count == 0 ? 'gj' : 'j'",                   'nse', mode = 'nv',   disabled = not jk_wrap },
    { '<M-o>',                 '<C-f>',                                       'n',   mode = 'c' },
    --[[
    -- goto marker (move to plugins/which-key.lua)
    { "`",                     "'",                                           'ns' },
    { "'",                     "`",                                           'ns' },
    --]]
    -- Go to home and end using capitalized directions
    { 'H',                     '^',                                           'ns' },
    { 'L',                     '$',                                           'ns' },
    -- visual selection excluding newline & space
    { 'H',                     '^',                                           'ns',  mode = 'x' },
    { 'L',                     'g_',                                          'ns',  mode = 'x' },
    -- join lines without space
    { 'J',                     'gJ',                                          'ns',  mode = 'nv' },
    { 'gJ',                    'J',                                           'ns',  mode = 'nv' },
    -- 去掉搜索高亮
    { '<leader>/',             ':nohls<CR>',                                  'ns' },
    -- command history
    -- { '<leader>;', ':<C-f>', 'ns', mode = 'n' }
    { '@',                     ':normal @',                                   'n',   mode = 'v' },
    { '<leader>q',             '<cmd>CloseExceptLast<CR>',                    'ns' },
    { '<M-q>',                 '<cmd>TabpageQuit<CR>',                        'ns',  mode = 'nit' },
    -- 防止水平滑动的时候失去选择
    { '<',                     '<gv',                                         'ns',  mode = 'x' },
    { '>',                     '>gv',                                         'ns',  mode = 'x' },
    -- toggle number
    { '<leader>n',             '<cmd>set relativenumber! | :set number!<CR>', 'ns' },
    -- Y yank until the end of line
    { 'Y',                     'y$',                                          'ns' },
    -- repeat substitution
    { '&',                     ':%&<CR>',                                     'ns' },
    -- go to end of parenthesis/brackets/quotes without switching insert mode
    --[[ provided by vim-rsi
    { '<C-l>', '<C-o>A',    'ns', mode = 'i' },
    { '<C-a>', '<C-o>^',    'ns', mode = 'i' },
    { '<C-e>', '<C-o>$',    'ns', mode = 'i' },
    { '<C-f>', '<C-o>l',    'ns', mode = 'i' },
    { '<C-b>', '<C-o>h',    'ns', mode = 'i' },
    { '<M-f>', '<C-o>w',    'ns', mode = 'i' },
    { '<M-b>', '<C-o>b',    'ns', mode = 'i' },
    { '<C-w>', '<C-o>db',   'ns', mode = 'i' },

    { '<C-o>', '<C-f>',     'n',  mode = 'c' },
    { '<C-a>', '<Home>',    'n',  mode = 'c' },
    { '<C-e>', '<End>',     'n',  mode = 'c' },
    { '<C-f>', '<Right>',   'n',  mode = 'c' },
    { '<C-b>', '<Left>',    'n',  mode = 'c' },
    { '<M-f>', '<S-Right>', 'n',  mode = 'c' },
    { '<M-b>', '<S-Left>',  'n',  mode = 'c' },
    { '<C-d>', '<Delete>',  'n',  mode = 'c' },
    --]]
}


vim.api.nvim_command [[
nnoremap <expr><silent><Esc> len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) ? ":ccl<CR>" : "\<Esc>"
"快速编辑自定义宏
nnoremap <leader>xm  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
]]
