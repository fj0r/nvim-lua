local wk = require("which-key")

wk.setup {
    plugins = {
        marks = true,         -- shows a list of your marks on ' and `
        registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
    },
    win = {
        padding = { 0, 0, 0, 0 },
    },
    disable = {
        ft = {},
        bt = { "TelescopePrompt" },
    },
    triggers = {
      { "<auto>", mode = "nxsot" },
      { "<leader>", mode = { "n", "v" } },
    },
    -- preset = "modern",
}

wk.add {
    { "'", "`", desc = "marks", mode = { "n", "v" }, remap = true },
    -- recursive!
    --{ "`", "'", desc = 'marks', mode = { "n", "v" }, remap = true },
}
