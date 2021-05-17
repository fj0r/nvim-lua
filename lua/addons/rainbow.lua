vim.api.nvim_command('autocmd BufEnter * RainbowParentheses')

vim.g['rainbow#max_level'] = 16
vim.g['rainbow#pairs'] = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

-- List of colors that you do not want. ANSI code or #RRGGBB
vim.g['rainbow#blacklist'] = { 243, 248, 15 }
