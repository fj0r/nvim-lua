local s = require('setup')
local m = s.mod

if vim.fn.exists('$NVIM_ARROW') == 1 then
    local opt = { noremap = true, silent = true }
    for o, k in pairs(vim.g.arrow_keys) do
        vim.keymap.set({ 'n', 'x' }, k, o, opt)

        vim.keymap.set('', m(k), '<C-W>' .. o, opt)
        vim.keymap.set({ 'i', 't' }, m(k), '<C-\\><C-N><C-w>' .. o, opt)
        vim.keymap.set('', m(k, true), '<C-W><S-' .. o .. '>', opt)
    end

    s.keymap_table {
        { vim.g.arrow_keys.k, "v:count == 0 ? 'gk' : 'k'", 'nse', mode = 'nv',   disabled = not vim.g.jk_wrap },
        { vim.g.arrow_keys.j, "v:count == 0 ? 'gj' : 'j'", 'nse', mode = 'nv',   disabled = not vim.g.jk_wrap },
        { vim.g.mapesc,       '<ESC>',                     'ns',  mode = 'nicv', disabled = not vim.g.mapesc },
        -- Go to home and end using capitalized directions
        { 'J',                '^',                         'ns' },
        { 'L',                '$',                         'ns' },
        -- visual selection excluding newline & space
        { 'J',                '^',                         'ns',  mode = 'x' },
        { 'L',                'g_',                        'ns',  mode = 'x' },
        -- join lines without space
        { 'K',                'gJ',                        'ns',  mode = 'nv' },
        { 'gK',               'J',                         'ns',  mode = 'nv' },
    }
end
