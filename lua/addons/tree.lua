local g = vim.g
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local keybindings = {
    {key = "u",              cb = ":lua require'some_module'.some_function()<cr>"},

    -- default mappings
    {key = "l",              cb =  tree_cb("edit")},
    {key = "h",              cb =  tree_cb("close_node")},
    {key = "<C-s>",          cb =  tree_cb("split")},
    {key = "<CR>",           cb =  tree_cb("edit")},
    {key = "<2-LeftMouse>",  cb =  tree_cb("edit")},
    {key = "<2-RightMouse>", cb =  tree_cb("cd")},
    {key = "<C-]>",          cb =  tree_cb("cd")},
    {key = "<C-v>",          cb =  tree_cb("vsplit")},
    {key = "<C-t>",          cb =  tree_cb("tabnew")},
    {key = "<",              cb =  tree_cb("prev_sibling")},
    {key = ">",              cb =  tree_cb("next_sibling")},
    {key = "<BS>",           cb =  tree_cb("close_node")},
    {key = "<Tab>",          cb =  tree_cb("preview")},
    {key = "I",              cb =  tree_cb("toggle_ignored")},
    {key = "H",              cb =  tree_cb("toggle_dotfiles")},
    {key = "R",              cb =  tree_cb("refresh")},
    {key = "a",              cb =  tree_cb("create")},
    {key = "d",              cb =  tree_cb("remove")},
    {key = "r",              cb =  tree_cb("rename")},
    {key = "<C-r>",          cb =  tree_cb("full_rename")},
    {key = "x",              cb =  tree_cb("cut")},
    {key = "c",              cb =  tree_cb("copy")},
    {key = "p",              cb =  tree_cb("paste")},
    {key = "[c",             cb =  tree_cb("prev_git_item")},
    {key = "]c",             cb =  tree_cb("next_git_item")},
    {key = "-",              cb =  tree_cb("dir_up")},
    {key = "q",              cb =  tree_cb("close")},
}

g.nvim_tree_show_icons = {
    git= 1,
    folders= 0,
    files= 0,
}
g.nvim_tree_icons = {
    default= '',
    symlink= '@',
    git= {
        unstaged= "*",
        staged= "~",
        unmerged= "_",
        renamed= "^",
        untracked= "!"
    },
    folder= {
        default= "+",
        open= "-",
        symlink= "@"
    }
}
g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' } -- List of filenames that gets highlighted with NvimTreeSpecialFile
g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_git_hl = 1 --0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 --0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' --This is the default. See :help filename-modifiers for more options
g.nvim_tree_width_allow_resize  = 1 --0 by default, will not resize the tree when opening a file
g.nvim_tree_add_trailing = 1 --0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree

require'nvim-tree'.setup {
    hijack_directories = {
        auto_open = true,
    },
    disable_netrw = false, --1 by default, disables netrw
    hijack_netrw = false, --1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
    open_on_tab = false,
    -- lsp_diagnostics = 1, --0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
    update_cwd = true,
    view = { mappings = { list = keybindings } },
    renderer = {
        indent_markers = { enable = true }
    },
    filters = {
        dotfiles = false,
    },
    git = {
        ignore = false,
    },
    actions = {
        change_dir = {
            enable = true,
            global = false,
        },
        open_file = {
            quit_on_open = true,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
                    buftype  = { "nofile", "terminal", "help", },
                }
            }
        }
    }
}


local m = function (k, v)
    vim.api.nvim_set_keymap('n', k, v, {noremap=true, silent=true})
end

m('<leader>e', ':NvimTreeToggle<CR>')
m('<leader>z', ':NvimTreeFindFile<CR>')

local wo = require'nvim-tree.view'.View.winopts
wo.relativenumber = false
wo.signcolumn = 'no'
