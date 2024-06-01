local s = require('setup')
local m = s.mod
vim.g.arrow_keys = {
    ['j'] = 'j',
    ['k'] = 'k',
    ['l'] = 'l',
    ['h'] = 'h',
    [';'] = ';',
}

if vim.fn.exists('$NVIM_ARROW') == 1 then
    local opt = { noremap = true, silent = true }
    local keys = {
        { -- shift right
            ['h'] = 'j',
            ['j'] = 'k',
            ['k'] = 'l',
            ['l'] = ';',
            [';'] = 'h',
        },
        { -- d/u l/r
            ['h'] = 'l',
            ['j'] = 'j',
            ['k'] = 'k',
            ['l'] = ';',
            [';'] = 'h',
        },
    }
    vim.g.arrow_keys = keys[tonumber(os.getenv('NVIM_ARROW'))]
    for o, k in pairs(vim.g.arrow_keys) do
        vim.keymap.set({ 'n', 'x' }, k, o, opt)

        vim.keymap.set('', m(k), '<C-W>' .. o, opt)
        vim.keymap.set({ 'i', 't' }, m(k), '<C-\\><C-N><C-w>' .. o, opt)
        vim.keymap.set('', m(k, true), '<C-W><S-' .. o .. '>', opt)
    end

    vim.g.mapesc = "<m-'>"
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
