local neogit = require'neogit'

neogit.setup {
    disable_signs = false,
    disable_context_highlighting = false,
    -- customize displayed signs
    signs = {
        -- { CLOSED, OPENED }
        section = { "├─", "│ " },
        item = { "├─", "│ " },
        hunk = { "", "" },
    },
}

vim.api.nvim_set_keymap('n', '<Leader>s', "<cmd>lua require'neogit'.open({kind='split'})<cr>", { noremap = true })
