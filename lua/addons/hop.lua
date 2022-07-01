local m = vim.api.nvim_set_keymap
for _, o in ipairs({'n', 'v', 'x'}) do
    m(o, '<leader><space>', "<cmd>lua require'hop'.hint_words()<cr>", {})
    --m(o, 's', "<cmd>lua require'hop'.hint_words()<cr>", {})
    m(o, '<leader>j', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})
    --m(o, '<C-s>', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})
    m(o, '<leader>k', "<cmd>lua require'hop'.hint_lines()<cr>", {})
    m(o, '<leader>c', "<cmd>lua require'hop'.hint_char1()<cr>", {})
    --m(o, '<leader>z', "<cmd>lua require'hop'.hint_char2()<cr>", {})
    --m(o, '<leader>p', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
end

require'hop'.setup {}

