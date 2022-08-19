vim.o.hidden = true
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-N>", {noremap = true, silent = true})

local wh = require'utils'.which

require'toggleterm'.setup{
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            local c = vim.o.columns * 0.4
            return c > 80 and c or 80
        end
    end,
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    persist_size = true,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = 'horizontal',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = wh'nu' or wh'zsh' or wh'bash', -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = 'single',
        width = 80,
        height = 40,
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    },
    on_close = function(term)
        -- vim.cmd("Closing terminal")
    end,
}


vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>exe v:count1 \"ToggleTerm direction=vertical\"<CR>", {noremap = true, silent = true})

local Terminal = require'toggleterm.terminal'.Terminal
local ipython = Terminal:new {
    cmd = 'ipython3',
    direction = 'float',
}
function _ipython() ipython:toggle() end
vim.api.nvim_set_keymap("n", "<leader>y", "<cmd>lua _ipython()<CR>", {noremap = true, silent = true})

