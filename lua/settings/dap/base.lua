function _dap_stop()
    require'dap'.close()
    require'dapui'.close()
end

function _dap_continue()
    require'dapui'.open()
    require'dap'.continue()
end

local keymaps = {
    ['[b'] = require'dap'.toggle_breakpoint,
    ['[c'] = _dap_continue,
    ['[s'] = require'dap'.step_over,
    ['[i'] = require'dap'.step_into,
    ['[o'] = require'dap'.step_out,
    ['[g'] = require'dap'.goto_,
    ['[r'] = require'dap'.run_to_cursor,
    ['[x'] = require'dap'.repl.open,
    ['[l'] = require'dap'.list_breakpoints,
    ['[B'] = function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    ['[L'] = function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    ['[C'] = require'dap'.run_last,
    ['[p'] = _dap_stop,
}

for k, v in pairs(keymaps) do
    vim.keymap.set('n', k, v, { noremap = true })
end

for _, v in ipairs {'n', 'v'} do
    vim.keymap.set(v, '[v', require'dapui'.eval, { noremap = true})
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
        max_width = nil   -- Floats will be treated as percentage of your screen.
    },
})

