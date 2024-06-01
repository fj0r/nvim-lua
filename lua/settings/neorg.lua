require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {  -- Adds pretty icons to your documents
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            }
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                neorg_leader = "[",
            }
        },
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
            },
        },
    },
}
