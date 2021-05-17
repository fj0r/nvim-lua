vim.o.hidden = true
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-N>", {noremap = true, silent = true})

require("toggleterm").setup{
    size = 20,
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = '3', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    persist_size = true,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = 'horizontal',
    close_on_exit = false, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = 'curved',
        width = 80,
        height = 40,
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    },
    on_open = function (term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    on_close = function(term)
        vim.cmd("Closing terminal")
    end,
}

