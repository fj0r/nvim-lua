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
        {
            [';'] = 'h',
            ['j'] = 'j',
            ['k'] = 'k',
            ['l'] = 'l',
            ['h'] = ';',
        },
        {
            [';'] = 'h',
            ['j'] = 'j',
            ['k'] = 'k',
            ['h'] = 'l',
            ['l'] = ';',
        },
        {
            [';'] = 'h',
            ['h'] = 'j',
            ['j'] = 'k',
            ['k'] = 'l',
            ['l'] = ';',
        },
    }
    vim.g.arrow_keys = keys[tonumber(os.getenv('NVIM_ARROW'))]
    for o, k in pairs(vim.g.arrow_keys) do
        vim.keymap.set('n', k, o, opt)
        vim.keymap.set('v', k, o, opt)

        vim.keymap.set('', '<C-' .. k .. '>', '<C-W>' .. o, opt)
        vim.keymap.set('i', '<C-' .. k .. '>', '<C-\\><C-N><C-w>' .. o, opt)
        vim.keymap.set('t', '<C-' .. k .. '>', '<C-\\><C-N><C-w>' .. o, opt)
        vim.keymap.set('', '<M-' .. k .. '>', '<C-W><S-' .. o .. '>', opt)
    end
end
