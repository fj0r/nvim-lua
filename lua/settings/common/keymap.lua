local s = require('setup')
local m = s.mod
vim.g.prefer_alt = tonumber(os.getenv('NVIM_PREFER_ALT') or os.getenv('PREFER_ALT') or 0)
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapesc = m '[' -- nil | '<M-[>' | '<C-;>'
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local jk_wrap = os.getenv('NVIM_JK_WRAP') == '1'

s.keymap_table {
    --[[
    -- nvim-taberm: opts.keymap.normal  @manifest/term.lua
    { m ']',             '<C-\\><C-n>',                                 'ns',  mode = 't' },
    --]]
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
    -- no highlight search
    { '<leader>/',        ':nohls<CR>',                                  'ns' },
    -- command history
    -- { '<leader>;', ':<C-f>', 'ns', mode = 'n' }
    { '@',                ':normal @',                                   'n',   mode = 'x' },
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
}

if vim.g.prefer_alt > 0 then
    s.keymap_table {
        { m 'f', '<C-f>', 'ns' },
        { m 'b', '<C-b>', 'ns' },
        { m 'u', '<C-u>', 'ns' },
        { m 'd', '<C-d>', 'ns' },
        { m 'e', '<C-e>', 'ns' },
        { m 'y', '<C-y>', 'ns' },
        { m 'i', '<C-i>', 'ns' },
        { m 'o', '<C-o>', 'ns' },
    }
end

-----------------
-- Viewer mode --
-----------------

local run_normal = function(k)
    return function()
        local mode = vim.fn.mode()
        local key
        if mode == 't' then
            key = "<C-\\><C-n>" .. k
        elseif mode == 'i' then
            key = "<Esc>" .. k
        else
            key = k
        end
        s.feedkeys(key)
    end
end

s.keymap_table {
    { '<M-,>', run_normal('<C-b>'), 'ns', mode = 'nicvt' },
    { '<M-.>', run_normal('<C-f>'), 'ns', mode = 'nicvt' },
    { '<M-/>', run_normal('?'),     'ns', mode = 'nicvt' },
}

------------------------------
-- Readline style insertion --
------------------------------

local fn = vim.fn

local mkskipchar = function(pattern, right, many)
    if many then
        return function()
            local c = fn.getline('.')
            local p = fn.col('.')
            local n = 0
            local b, e, l
            if right then
                b, e, l = p, #c, 1
            else
                b, e, l = p - 1, 1, -1
            end
            for i = b, e, l do
                local cur = string.sub(c, i, i)
                if pattern[cur] then
                    n = n + 1
                else
                    break
                end
            end
            local v = ""
            for _ = 1, n do
                v = v .. (right and '<Right>' or '<Left>')
            end
            return v
        end
    else
        return function()
            local c = fn.getline('.')
            local p = fn.col('.')
            local x
            if right then
                x = p
            else
                x = p - 1
            end
            if pattern[string.sub(c, x, x)] then
                if right then
                    return '<Right>'
                else
                    return '<Left>'
                end
            else
                return ""
            end
        end
    end
end

local skipleftone = mkskipchar(s.char_dict("\\[{(\"'<"), false, false)
local skiprightone = mkskipchar(s.char_dict("\\]})\"'>"), true, false)
local wd_iforward = function()
    local i = skiprightone()
    s.feedkeys(i == "" and '<S-Right>' or i)
end

local iln = function() return fn.col('.') > fn.strlen(fn.getline('.')) end
local cln = function() return fn.getcmdpos() > fn.strlen(fn.getcmdline() or '') end
local ipv = function() return iln() or fn.pumvisible() ~= 0 end

local act = {
    iend = { ipv, '<C-e>', '<End>' },
    iforward = { iln, '<C-f>', '<Right>' },
    idelete = { iln, '<C-d>', '<Del>' },
    cdelete = { cln, '<C-d>', '<Del>' },
}

for k, v in pairs(act) do
    act[k] = function()
        s.feedkeys(v[1]() and v[2] or v[3])
    end
end

s.keymap_table {
    { m('a'),       '<C-o>^',     'ns', mode = 'i' },
    { m('e'),       act.iend,     'ns', mode = 'i' },
    { m('f'),       wd_iforward,  'ns', mode = 'i' },
    { m('b'),       '<S-Left>',   'ns', mode = 'i' },
    { m('f', true), act.iforward, 'ns', mode = 'i' },
    { m('b', true), '<Left>',     'ns', mode = 'i' },
    { m('w'),       '<C-o>db',    'ns', mode = 'i' },
    { m('d'),       act.idelete,  'ns', mode = 'i' },

    { m('o'),       '<C-f>',      'n',  mode = 'c' },
    { m('a'),       '<Home>',     'n',  mode = 'c' },
    { m('e'),       '<End>',      'n',  mode = 'c' },
    { m('f'),       '<S-Right>',  'n',  mode = 'c' },
    { m('b'),       '<S-Left>',   'n',  mode = 'c' },
    { m('f', true), '<Right>',    'n',  mode = 'c' },
    { m('b', true), '<Left>',     'n',  mode = 'c' },
    { m('n'),       '<down>',     'n',  mode = 'c' },
    { m('p'),       '<up>',       'n',  mode = 'c' },
    { m('d'),       act.cdelete,  'n',  mode = 'c' },
}
