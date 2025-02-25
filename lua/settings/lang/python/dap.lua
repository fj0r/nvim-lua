local dap = require 'dap'

dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        local port = (config.connect or config).port
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = (config.connect or config).host or "127.0.0.1",
        })
    else
        cb({
            type = "executable",
            command = "python3",
            args = { "-m", "debugpy.adapter" },
        })
    end
end

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "FastAPI",
        module = "uvicorn",
        args = { "main:app", "-h", "0.0.0.0", "-p", "8002" },
        env = function()
            local variables = {
                PYTHONPATH = vim.fn.getcwd()
            }
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
        end,
        subProcess = false,
    },
    {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return nil
            end
        end,
    },
}
