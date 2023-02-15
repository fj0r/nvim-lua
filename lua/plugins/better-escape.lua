require("better_escape").setup {
    mapping = { 'kl' }, -- ds: backends
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    -- keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    keys = function()
        -- can't escape terminal mode
        -- https://github.com/max397574/better-escape.nvim/issues/23
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
    end,
}
