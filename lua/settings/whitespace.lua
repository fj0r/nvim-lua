require('whitespace-nvim').setup({
    -- configuration options and their defaults

    -- `highlight` configures which highlight is used to display
    -- trailing whitespace
    highlight = 'DiffDelete',

    -- `ignored_filetypes` configures which filetypes to ignore when
    -- displaying trailing whitespace
    ignored_filetypes = vim.g.plugin_filetypes,
})

return {
    setup = function(plugin, ctx)
        ctx.apply_keymap(plugin, {
            -- remove trailing whitespace with a keybinding
            remove = require('whitespace-nvim').trim
        })
    end
}
