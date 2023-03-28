require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
    },
    window = {
        padding = { 0, 0, 0, 0 },
    },
    disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
    },
}
