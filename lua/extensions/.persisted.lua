require("persisted").setup {
    dir = vim.g.data_root.."/sessions/", -- directory where session files are saved
    autosave = true,
    autoload = true
}
