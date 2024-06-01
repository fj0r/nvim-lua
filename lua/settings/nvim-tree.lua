-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local api = require("nvim-tree.api")

local function edit_or_open()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
    else
        -- open file
        api.node.open.edit()
        -- Close the tree if file was opened
        api.tree.close()
    end
end

-- open as vsplit on current node
local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
    else
        -- open file as vsplit
        api.node.open.vertical()
    end

    -- Finally refocus on tree if it was lost
    api.tree.focus()
end

local on_attach = function(bufnr)
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
    vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
    vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
end


local common = {
    view = {
        signcolumn = "no",
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    update_focused_file = {
        enable = true,
    },
    filters = { custom = { "^.git$" } },
    on_attach = on_attach
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
                default = '┊',
                symlink = '┊',
                git = {
                    unstaged = "+",
                    staged = "-",
                    unmerged = "=",
                    renamed = "%",
                    untracked = "*",
                    deleted = "x",
                    ignored = "!",
                },
                -- ┼╞├┝┆┊╎│└
                folder = {
                    arrow_closed = " ",
                    arrow_open = " ",
                    default = "┼",
                    open = "├",
                    empty = "╞",
                    empty_open = "╞",
                    symlink = "┊",
                    symlink_open = "┆",
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
                git = {
                    unmerged = "=",
                    deleted = "x",
                },
                -- ┼╞├┝┆┊╎│└
                folder = {
                    arrow_closed = " ",
                    arrow_open = " ",
                    default = "+",
                    open = "-",
                    empty = " ",
                    empty_open = " ",
                    symlink = "┊",
                    symlink_open = "┆",
                }
            }
        },
    },
}


require 'nvim-tree'.setup(vim.tbl_deep_extend('force', common, special_files))

local nvimTreeFocusOrToggle = function ()
	local currentBuf = vim.api.nvim_get_current_buf()
	local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
	if currentBufFt == "NvimTree" then
		api.tree.toggle()
	else
		api.tree.focus()
	end
end

-- vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', 'nvimTreeFocusOrToggle', { noremap = true, silent = true })
