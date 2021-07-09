for _, m in ipairs({'n', 'v', 'x'}) do
    vim.api.nvim_set_keymap(m, '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {})
    vim.api.nvim_set_keymap(m, '<leader>p', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
    vim.api.nvim_set_keymap(m, '<leader>j', "<cmd>lua require'hop'.hint_lines()<cr>", {})
    vim.api.nvim_set_keymap(m, '<leader>k', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})
    vim.api.nvim_set_keymap(m, '<leader>d', "<cmd>lua require'hop'.hint_char1()<cr>", {})
    vim.api.nvim_set_keymap(m, '<leader>s', "<cmd>lua require'hop'.hint_char2()<cr>", {})
end

require'hop'.setup {
    keys = 'etovxqpdygfblzhckisuran',
    term_seq_bias = 0.5,
}
