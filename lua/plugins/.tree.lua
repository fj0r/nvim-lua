local keybindings = {
    { key = {"<CR>", "l", "<2-LeftMouse>"}, action = "edit" },
    { key = {"h", "<BS>"},                  action =  "close_node"},
    { key = "<C-e>",                        action = "edit_in_place" },
    { key = {"O"},                          action = "edit_no_picker" },
    { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
    { key = "<C-v>",                        action = "vsplit" },
    { key = "<C-s>",                        action = "split" },
    { key = "<C-t>",                        action = "tabnew" },
    { key = "<",                            action = "prev_sibling" },
    { key = ">",                            action = "next_sibling" },
    { key = "P",                            action = "parent_node" },
    { key = "<Tab>",                        action = "preview" },
    { key = "K",                            action = "first_sibling" },
    { key = "J",                            action = "last_sibling" },
    { key = "I",                            action = "toggle_git_ignored" },
    { key = "H",                            action = "toggle_dotfiles" },
    { key = "R",                            action = "refresh" },
    { key = "a",                            action = "create" },
    { key = "d",                            action = "remove" },
    { key = "D",                            action = "trash" },
    { key = "r",                            action = "rename" },
    { key = "<C-r>",                        action = "full_rename" },
    { key = "x",                            action = "cut" },
    { key = "c",                            action = "copy" },
    { key = "p",                            action = "paste" },
    { key = "y",                            action = "copy_name" },
    { key = "Y",                            action = "copy_path" },
    { key = "gy",                           action = "copy_absolute_path" },
    { key = "[c",                           action = "prev_git_item" },
    { key = "]c",                           action = "next_git_item" },
    { key = "-",                            action = "dir_up" },
    { key = "s",                            action = "system_open" },
    { key = "f",                            action = "live_filter" },
    { key = "F",                            action = "clear_live_filter" },
    { key = "q",                            action = "close" },
    { key = "g?",                           action = "toggle_help" },
    { key = "W",                            action = "collapse_all" },
    { key = "S",                            action = "search_node" },
    { key = "<C-k>",                        action = "toggle_file_info" },
    { key = ".",                            action = "run_file_command" }
}

local common = {
    view = {
        signcolumn = "no",
        mappings = {
            list = keybindings,
        },
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    update_focused_file = {
        enable = true,
    },
}

local special_files = {
    renderer = {
        special_files = {
            "justfile", "Makefile", ".tasks", ".yabs", "mutagen.yml",
            ".dockerignore", "Dockerfile", "docker-compose.yml",
            ".git", ".gitignore", ".gitmodules",
            ".github", ".gitlab-ci.yml",
            "Cargo.toml", "Cargo.lock",
            "stack.yml", "package.yaml", "*.cabal",
            "requirements.txt",
            "package.json", "package-lock.json", "tsconfig.json", "tslint.json",
            "go.mod", "go.sum",
            "README.md", "readme.md", "ChangeLog.md", "LICENSE"
        },
    }
}

---@diagnostic disable-next-line: unused-local
local tree_orthodox = {
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
                corner = "│ ",
                edge = "│ ",
                item = "│ ",
                none = "│ ",
            },
        },
        icons = {
            glyphs = {
                default= '┊',
                symlink= '┊',
                git= {
                    unstaged= "+",
                    staged= "-",
                    unmerged= "=",
                    renamed= "%",
                    untracked= "*",
                    deleted = "x",
                    ignored = "!",
                },
                -- ┼╞├┝┆┊╎│└
                folder= {
                    arrow_closed = " ",
                    arrow_open = " ",
                    default= "┼",
                    open= "├",
                    empty = "╞",
                    empty_open = "╞",
                    symlink= "┊",
                    symlink_open= "┆",
                }
            }
        },
    },
}

---@diagnostic disable-next-line: unused-local
local tree_modern = {
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                none = " ",
            },
        },
        icons = {
            glyphs = {
                default = " ",
                symlink = " ",
                git= {
                    unmerged= "=",
                    deleted = "x",
                },
                -- ┼╞├┝┆┊╎│└
                folder= {
                    arrow_closed = " ",
                    arrow_open = " ",
                    default= "+",
                    open= "-",
                    empty = " ",
                    empty_open = " ",
                    symlink= "┊",
                    symlink_open= "┆",
                }
            }
        },
    },
}

require'nvim-tree'.setup(vim.tbl_deep_extend('force', common, special_files))

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>z', ':NvimTreeFindFile<CR>', {noremap=true, silent=true})
