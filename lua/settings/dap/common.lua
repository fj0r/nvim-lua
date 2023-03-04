local dap_stop = function()
    require 'dap'.close()
    require 'dapui'.close()
end

local dap_continue = function()
    require 'dapui'.open()
    require 'dap'.continue()
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

return {
    fns = {
        toggle_breakpoint = require 'dap'.toggle_breakpoint,
        list_breakpoints = require 'dap'.list_breakpoints,
        condition_breakpoint = function()
            require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        log_breakpoint = function()
            require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        end,
        continue = dap_continue,
        step_over = require 'dap'.step_over,
        goto_ = require 'dap'.goto_,
        step_into = require 'dap'.step_into,
        out = require 'dap'.step_out,
        run_to_cursor = require 'dap'.run_to_cursor,
        repl_open = require 'dap'.repl.open,
        run_last = require 'dap'.run_last,
        stop = dap_stop,
        eval = require 'dapui'.eval,
    }
}
