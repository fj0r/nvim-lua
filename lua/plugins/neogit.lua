if not vim.g.has_git then
    return
end

local neogit = require 'neogit'

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
    integrations = {
        diffview = true
    }
}

--vim.keymap.set('n', '<Leader>gg', "<cmd>lua require'neogit'.open({kind='split'})<cr>", { noremap = true })
vim.keymap.set('n', '<Leader>gg',
    function()
        require 'neogit'.open({ kind = 'split' })
    end,
    { noremap = true, desc = 'neogit' }
)
