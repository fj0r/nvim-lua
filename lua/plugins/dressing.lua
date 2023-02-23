require('dressing').setup({
    select = {
        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = require('telescope.themes').get_dropdown {
            layout_config = { height = math.floor(vim.fn.winheight(0) / 2) }
        },
    },
})
