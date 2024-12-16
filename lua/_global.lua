if vim.fn.exists('$NVIM_ARROW') == 1 then
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
else
    vim.g.arrow_keys = {
        ['j'] = 'j',
        ['k'] = 'k',
        ['l'] = 'l',
        ['h'] = 'h',
        [';'] = ';',
    }
end

vim.g.prefer_alt = tonumber(os.getenv('NVIM_PREFER_ALT') or os.getenv('PREFER_ALT') or 0)
