local keymaps = {
    ['[p'] = "<cmd>lua require'dap'.stop()<cr>",
    ['[b'] = "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    ['[c'] = "<cmd>lua require'dap'.continue()<cr>",
    ['[s'] = "<cmd>lua require'dap'.step_over()<cr>",
    ['[i'] = "<cmd>lua require'dap'.step_into()<cr>",
    ['[o'] = "<cmd>lua require'dap'.step_out()<cr>",
    ['[g'] = "<cmd>lua require'dap'.goto_()<cr>",
    ['[x'] = "<cmd>lua require'dap'.repl.open()<cr>",
    ['[l'] = "<cmd>lua require'dap'.list_breakpoints()<cr>",
    ['[B'] = "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    ['[L'] = "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    ['[C'] = "<cmd>lua require'dap'.run_last()<CR>",
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
        expanded = "⯆",
        collapsed = "⯈",
        circular = "↺"
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
        width = 40,
        position = "left" -- Can be "left" or "right"
    },
    tray = {
        elements = {
            "repl"
        },
        height = 10,
        position = "bottom" -- Can be "bottom" or "top"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil   -- Floats will be treated as percentage of your screen.
    }
})

