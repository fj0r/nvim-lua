local picker = require('window-picker')

picker.setup {
    show_prompt = false,
    selection_chars = 'FJDKSLA;CMRUEIWOQP',
    filter_func = nil,
    filter_rules = {
        autoselect_one = true,
        include_current_win = true,
        bo = {
            filetype = { 'NvimTree', "neo-tree", "neo-tree-popup", "notify" },
            buftype = {},
        },
        wo = {},
        file_path_contains = {},
        file_name_contains = {},
    },
    highlights = {
        enabled = true,
        statusline = {
            focused = {
                fg = '#ededed',
                bg = '#e35e4f',
                bold = true,
            },
            unfocused = {
                fg = '#ededed',
                bg = '#44cc41',
                bold = true,
            },
        },
        winbar = {
            focused = {
                fg = '#ededed',
                bg = '#e35e4f',
                bold = true,
            },
            unfocused = {
                fg = '#ededed',
                bg = '#44cc41',
                bold = true,
            },
        },
    },
}

local pick_win = function()
    local picked_window_id = picker.pick_window { hint = 'floating-big-letter' } or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end

return {
    setup = function(plugin, ctx)
        ctx.apply_keymap(plugin.keys, { pick_win = pick_win })
    end

}
