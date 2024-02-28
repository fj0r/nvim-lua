local s = require('setup')
local m = s.mod
vim.g.prefer_alt = tonumber(os.getenv('NVIM_PREFER_ALT') or os.getenv('PREFER_ALT') or 0)
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapesc = m '[' -- nil | '<M-[>' | '<C-;>'
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local jk_wrap = os.getenv('NVIM_JK_WRAP') == '1'

local pumkey = function(p, o)
    return function()
        local f = vim.fn
        local k
        if f.col('.') > f.strlen(f.getline('.')) or f.pumvisible() then
            k = p
        else
            k = o
        end
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(k, true, false, true), 'm', true)
    end
end

s.keymap_table {
    { m '\\',             '<C-\\><C-n>',                                 'ns',  mode = 't' },
    { vim.g.mapesc,       '<ESC>',                                       'ns',  mode = 'nicv', disabled = not vim.g.mapesc },
    { vim.g.arrow_keys.k, "v:count == 0 ? 'gk' : 'k'",                   'nse', mode = 'nv',   disabled = not jk_wrap },
    { vim.g.arrow_keys.j, "v:count == 0 ? 'gj' : 'j'",                   'nse', mode = 'nv',   disabled = not jk_wrap },
    { '<M-o>',            '<C-f>',                                       'n',   mode = 'c' },
    --[[
    -- goto marker (move to plugins/which-key.lua)
    { "`",                     "'",                                           'ns' },
    { "'",                     "`",                                           'ns' },
    --]]
    -- Go to home and end using capitalized directions
    { 'H',                '^',                                           'ns' },
    { 'L',                '$',                                           'ns' },
    -- visual selection excluding newline & space
    { 'H',                '^',                                           'ns',  mode = 'x' },
    { 'L',                'g_',                                          'ns',  mode = 'x' },
    -- join lines without space
    { 'J',                'gJ',                                          'ns',  mode = 'nv' },
    { 'gJ',               'J',                                           'ns',  mode = 'nv' },
    -- 去掉搜索高亮
    { '<leader>/',        ':nohls<CR>',                                  'ns' },
    -- command history
    -- { '<leader>;', ':<C-f>', 'ns', mode = 'n' }
    { '@',                ':normal @',                                   'n',   mode = 'v' },
    { '<leader>q',        '<cmd>CloseExceptLast<CR>',                    'ns' },
    { m('q', true),       '<cmd>TabpageQuit<CR>',                        'ns',  mode = 'nit' },
    -- 防止水平滑动的时候失去选择
    { '<',                '<gv',                                         'ns',  mode = 'x' },
    { '>',                '>gv',                                         'ns',  mode = 'x' },
    -- toggle number
    { '<leader>n',        '<cmd>set relativenumber! | :set number!<CR>', 'ns' },
    -- Y yank until the end of line
    { 'Y',                'y$',                                          'ns' },
    -- repeat substitution
    { '&',                ':%&<CR>',                                     'ns' },

    { m('r'),             '<C-r>',                                       'ns',  mode = 'i' },
    -- go to end of parenthesis/brackets/quotes without switching insert mode
    { m('a'),             '<C-o>^',                                      'ns',  mode = 'i' },
    { m('e'),             pumkey('<end>', '<C-e>'),                      'ns',  mode = 'i' },
    { m('f'),             '<C-o>w',                                      'ns',  mode = 'i' },
    { m('b'),             '<C-o>b',                                      'ns',  mode = 'i' },
    { m('f', true),       '<C-o>l',                                      'ns',  mode = 'i' },
    { m('b', true),       '<C-o>h',                                      'ns',  mode = 'i' },
    { m('w'),             '<C-o>db',                                     'ns',  mode = 'i' },

    { m('o'),             '<C-f>',                                       'n',   mode = 'c' },
    { m('a'),             '<Home>',                                      'n',   mode = 'c' },
    { m('e'),             '<End>',                                       'n',   mode = 'c' },
    { m('f'),             '<S-Right>',                                   'n',   mode = 'c' },
    { m('b'),             '<S-Left>',                                    'n',   mode = 'c' },
    { m('f', true),       '<Right>',                                     'n',   mode = 'c' },
    { m('b', true),       '<Left>',                                      'n',   mode = 'c' },
    { m('n'),             '<down>',                                      'n',   mode = 'c' },
    { m('p'),             '<up>',                                        'n',   mode = 'c' },
    { m('d'),             '<Delete>',                                    'n',   mode = 'c' },
}

if vim.g.prefer_alt > 0 then
    s.keymap_table {
        { m 'f', '<C-f>', 'ns' },
        { m 'b', '<C-b>', 'ns' },
        { m 'u', '<C-u>', 'ns' },
        { m 'd', '<C-d>', 'ns' },
        { m 'e', '<C-e>', 'ns' },
        { m 'y', '<C-y>', 'ns' },
    }
end

vim.api.nvim_command [[
nnoremap <expr><silent><Esc> len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) ? ":ccl<CR>" : "\<Esc>"
"快速编辑自定义宏
nnoremap <leader>xm  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
]]
