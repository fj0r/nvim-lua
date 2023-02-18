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

