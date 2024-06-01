require('aerial').setup {
    backends = {
        ['_'] = { "lsp", "treesitter", "markdown", "man" },
        yaml = { "treesitter" }
    },
    attach_mode = 'global',
    filter_kind = {
        'Array',
        'Boolean',
        'Class',
        'Constant',
        'Constructor',
        'Enum',
        'EnumMember',
        'Event',
        'Field',
        'File',
        'Function',
        'Interface',
        'Key',
        'Method',
        'Module',
        'Namespace',
        'Null',
        'Number',
        'Object',
        'Operator',
        'Package',
        'Property',
        'String',
        'Struct',
        'TypeParameter',
        'Variable',
    },
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end
}

-- lualine.lua:62
-- possession.lua:31
-- telescope.lua:55,66

-- hi link AerialLine StatusLine
vim.cmd [[
hi link AerialLine MatchParen
hi link AerialLineNC CursorLine
]]
