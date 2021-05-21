local g = vim.g
--vim.g.nvim_tree_side = 'right' --left by default
--vim.g.nvim_tree_width = 40 --30 by default
g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
g.nvim_tree_gitignore = 0 -- 0 by default
g.nvim_tree_auto_open = 1 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_quit_on_open = 1 -- --0 by default, closes the tree when you open a file
g.nvim_tree_follow = 1 --0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_indent_markers = 1 --0 by default, this option shows indent markers when folders are open
g.nvim_tree_hide_dotfiles = 1 --0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_git_hl = 1 --0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 --0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' --This is the default. See :help filename-modifiers for more options
g.nvim_tree_tab_open = 0 --0 by default, will open the tree when entering a new tab and the tree was previously open
g.nvim_tree_width_allow_resize  = 1 --0 by default, will not resize the tree when opening a file
g.nvim_tree_disable_netrw = 0 --1 by default, disables netrw
g.nvim_tree_hijack_netrw = 0 --1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
g.nvim_tree_add_trailing = 1 --0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_lsp_diagnostics = 1 --0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' } -- List of filenames that gets highlighted with NvimTreeSpecialFile
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
        staged= "=",
        unmerged= "~",
        renamed= "^",
        untracked= "!"
    },
    folder= {
        default= "+",
        open= "-",
        symlink= "@"
    }
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
g.nvim_tree_bindings = {
    ["<CR>"] = ":YourVimFunction()<cr>",
    ["u"] = ":lua require'some_module'.some_function()<cr>",

    -- default mappings
    ["l"]              = tree_cb("edit"),
    ["h"]              = tree_cb("close_node"),
    ["<C-s>"]          = tree_cb("split"),
    ["<CR>"]           = tree_cb("edit"),
    ["<2-LeftMouse>"]  = tree_cb("edit"),
    ["<2-RightMouse>"] = tree_cb("cd"),
    ["<C-]>"]          = tree_cb("cd"),
    ["<C-v>"]          = tree_cb("vsplit"),
    ["<C-t>"]          = tree_cb("tabnew"),
    ["<"]              = tree_cb("prev_sibling"),
    [">"]              = tree_cb("next_sibling"),
    ["<BS>"]           = tree_cb("close_node"),
    ["<Tab>"]          = tree_cb("preview"),
    ["I"]              = tree_cb("toggle_ignored"),
    ["H"]              = tree_cb("toggle_dotfiles"),
    ["R"]              = tree_cb("refresh"),
    ["a"]              = tree_cb("create"),
    ["d"]              = tree_cb("remove"),
    ["r"]              = tree_cb("rename"),
    ["<C-r>"]          = tree_cb("full_rename"),
    ["x"]              = tree_cb("cut"),
    ["c"]              = tree_cb("copy"),
    ["p"]              = tree_cb("paste"),
    ["[c"]             = tree_cb("prev_git_item"),
    ["]c"]             = tree_cb("next_git_item"),
    ["-"]              = tree_cb("dir_up"),
    ["q"]              = tree_cb("close"),
}

local m = function (k, v)
    vim.api.nvim_set_keymap('n', k, v, {noremap=true, silent=true})
end

m('<leader>e', ':NvimTreeToggle<CR>')
m('<leader>xr', ':NvimTreeRefresh<CR>')
m('<leader>xf', ':NvimTreeFindFile<CR>')

local wo = require'nvim-tree.view'.View.winopts
wo.relativenumber = false
wo.signcolumn = 'no'
