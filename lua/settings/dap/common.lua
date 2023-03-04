local dap_stop = function()
    require 'dap'.close()
    require 'dapui'.close()
end

local dap_continue = function()
    require 'dapui'.open()
    require 'dap'.continue()
end

local keymaps = {
    --[[ set in Lazy.nvim
    { '[b', require 'dap'.toggle_breakpoint(), 'dap toggle breakpoint' },
    { '[l', require 'dap'.list_breakpoints(), 'dap list breakpoints' },
    { '[B', require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')), 'dap condition breakpoint' },
    { '[L', require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')), 'dap log breakpoint' },
    --]]
    { '[c', dap_continue, "dap continue" },
    { '[s', require 'dap'.step_over, "dap step over" },
    { '[i', require 'dap'.step_into, "dap step into" },
    { '[o', require 'dap'.step_out, "dap out" },
    { '[g', require 'dap'.goto_, "dap goto" },
    { '[r', require 'dap'.run_to_cursor, "dap run to cursor" },
    { '[x', require 'dap'.repl.open, "dap repl open" },
    { '[C', require 'dap'.run_last, "dap run last" },
    { '[p', dap_stop, "dap stop" },
}

for _, v in ipairs(keymaps) do
    vim.keymap.set('n', v[1], v[2], { noremap = true, desc = v[3] })
end

for _, v in ipairs { 'n', 'v' } do
    vim.keymap.set(v, '[v', require 'dapui'.eval, { noremap = true, desc = 'dapui eval' })
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
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "watches", size = 12 },
                --"console",
                "stacks",
                "breakpoints",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                { id = "scopes", size = 0.7 },
            },
            size = 12,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil -- Floats will be treated as percentage of your screen.
    },
})
