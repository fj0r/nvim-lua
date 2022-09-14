require("winshift").setup({
    highlight_moving_win = true,  -- Highlight the window being moved
    focused_hl_group = "Visual",  -- The highlight group used for the moving window
    moving_win_options = {
        -- These are local options applied to the moving window while it's
        -- being moved. They are unset when you leave Win-Move mode.
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
    },
    -- The window picker is used to select a window while swapping windows with
    -- ':WinShift swap'.
    -- A string of chars used as identifiers by the window picker.
    window_picker = function()
        return require("winshift.lib").pick_window({
            picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            filter_rules = {
                cur_win = true,
                floats = true,
                filetype = {
                    "NvimTree",
                    "neo-tree",
                    "neo-tree-popup",
                },
                buftype = {
                    "terminal",
                    "quickfix",
                },
                bufname = {
                    [[.*foo/bar/baz\.qux]]
                },
            },
        })
    end,
})

vim.api.nvim_set_keymap('n', '<leader>xs', '<cmd>WinShift swap<cr>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>xw', '<cmd>WinShift<cr>', { noremap = true})
