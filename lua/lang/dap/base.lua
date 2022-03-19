function _dap_stop()
    require'dap'.close()
    require'dapui'.close()
end

function _dap_continue()
    require'dapui'.open()
    require'dap'.continue()
end

local keymaps = {
    ['[b'] = "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    ['[c'] = "<cmd>lua _dap_continue()<cr>",
    ['[s'] = "<cmd>lua require'dap'.step_over()<cr>",
    ['[i'] = "<cmd>lua require'dap'.step_into()<cr>",
    ['[o'] = "<cmd>lua require'dap'.step_out()<cr>",
    --['[g'] = "<cmd>lua require'dap'.goto_()<cr>",
    ['[g'] = "<cmd>lua require'dap'.run_to_cursor()<cr>",
    ['[x'] = "<cmd>lua require'dap'.repl.open()<cr>",
    ['[l'] = "<cmd>lua require'dap'.list_breakpoints()<cr>",
    ['[B'] = "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    ['[L'] = "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    ['[C'] = "<cmd>lua require'dap'.run_last()<CR>",
    ['[p'] = "<cmd>lua _dap_stop()<cr>",
}

for k, v in pairs(keymaps) do
    vim.api.nvim_set_keymap('n', k, v, { noremap = true })
end

for _, v in ipairs {'n', 'v'} do
    vim.api.nvim_set_keymap(v, '[v',"<cmd>lua require'dapui'.eval()<cr>", { noremap = true})
end

vim.g.dap_virtual_text = true

require("dapui").setup({
    icons = {
        expanded = "-",
        collapsed = "+",
        circular = "="
    },
    mappings = {
        expand = "<CR>",
        open = "o",
        remove = "d"
    },
    sidebar = {
        elements = {
            -- You can change the order of elements in the sidebar
            "stacks",
            "watches",
            "scopes",
        },
        size = 40,
        position = "left" -- Can be "left" or "right"
    },
    tray = {
        elements = {
            "repl"
        },
        size = 10,
        position = "bottom" -- Can be "bottom" or "top"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil   -- Floats will be treated as percentage of your screen.
    }
})

