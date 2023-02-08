require'spectre'.setup()

vim.api.nvim_set_keymap('n', '<leader>S', '', {
    noremap = true,
    callback = function ()
        require("spectre").open()
    end
})

