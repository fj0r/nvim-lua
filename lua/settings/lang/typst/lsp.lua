vim.lsp.config('tinymist', {
    root_dir = util.find_git_ancestor,
    settings = {
        exportPdf = "never" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
    }
})
