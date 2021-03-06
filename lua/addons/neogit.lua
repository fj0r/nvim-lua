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
    mappings = {
        status = {
            ['i'] = 'PullPopup',
            ['o'] = 'PushPopup',
        },
    },
}

vim.api.nvim_set_keymap('n', '<Leader>v', "<cmd>lua require'neogit'.open({kind='split'})<cr>", { noremap = true })

