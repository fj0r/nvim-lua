local m = require('setup').mod

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- NOTE: this is changed from v1.x, which used the old style of highlight groups
-- in the form "LspDiagnosticsSignWarning"

require("neo-tree").setup({
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                --auto close
                require("neo-tree").close_all()
            end
        },
    },
    close_if_last_window = false,  -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = 'single', -- "double", "rounded", "single" or "solid"
    enable_git_status = vim.g.has_git,
    default_component_configs = {
        icon = {
            folder_closed = "+",
            folder_open = "-",
            folder_empty = "-",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = vim.g.has_git,
            highlight = "NeoTreeFileName",
        },
        git_status = vim.g.has_git and {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖", -- this can only be used in the git_status source
                renamed   = "", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            }
        } or nil,
    },
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            -- ["s"] = "open_split",
            -- ["v"] = "open_vsplit",
            ["s"] = "split_with_window_picker",
            ["v"] = "vsplit_with_window_picker",
            [m 's'] = "split_with_window_picker",
            [m 'v'] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            [vim.g.arrow_keys.l] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            [vim.g.arrow_keys.h] = "close_node",
            [vim.g.arrow_keys.j] = "move_down",
            [vim.g.arrow_keys.k] = "move_up",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "none" -- "none", "relative", "absolute"
                }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            ["Y"] = function(state)
                local node = state.tree:get_node()
                local full_path = node.path
                vim.fn.setreg('"', full_path)
                vim.fn.setreg('1', full_path)
                vim.fn.setreg('+', full_path)
            end,
            [m 'y'] = function(state)
                local node = state.tree:get_node()
                local relative_path = node.path:sub(#state.path + 2)
                vim.fn.setreg('"', relative_path)
                vim.fn.setreg('1', relative_path)
                vim.fn.setreg('+', relative_path)
            end,
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        }
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = vim.g.has_git,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
        },
        follow_current_file = {
            enabled = true,          -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        -- time the current file is changed while the tree is open.
        group_empty_dirs = false,               -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                -- ["D"] = "fuzzy_sorter_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
            }
        }
    },
    buffers = {
        follow_current_file = {
            enabled = true,          -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
            }
        },
    },
    git_status = vim.g.has_git and {
        window = {
            position = "float",
            mappings = {
                ["A"]  = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            }
        }
    } or nil
})

local notify = function(x) require('notify').notify(vim.inspect(x)) end
local km = {
    reveal = function()
        local cwd = vim.fn.getcwd()
        local bn = vim.api.nvim_buf_get_name(0)
        local sub = true
        -- file doesn't exist
        if vim.fn.filereadable(bn) == 0 then
            sub = false
        elseif string.sub(bn, 1, 7) == 'term://' then
            sub = false
        else
            for p in vim.fs.parents(bn) do
                if p == cwd then
                    sub = true
                    break
                end
            end
        end

        -- local cmd = 'Neotree float dir=' .. cwd .. ' '
        local cmd = 'Neotree dir=' .. cwd .. ' '
        if sub then
            cmd = cmd .. 'reveal_file=' .. bn
        else
            cmd = cmd .. 'reveal=false'
        end
        --notify(cmd)
        vim.api.nvim_command(cmd)
    end
}
return {
    setup = function(plugin, ctx)
        ctx.apply_keymap(plugin.keys, km)
    end
}
