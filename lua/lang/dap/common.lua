local dap = require'dap'
local lspconfig = require'lspconfig'

------ py
dap.adapters.python = {
    type = 'executable';
    command = '/usr/bin/python3';
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "Launch file";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}"; -- This configuration will launch the current file if used.
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
                return '/usr/bin/python3'
            end
        end;
    },
}

------ rust
--run docker with `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` or `--privileged`
dap.adapters.rust = {
    type = 'executable',
    command = 'lldb-vscode-11', -- my binary was called 'lldb-vscode-11'
    name = "lldb"
}

dap.configurations.rust = {
    {
        name = "Launch",
        type = "rust",
        request = 'launch',
        -- program = "${workspaceFolder}/target/debug/${file}"
        program = function ()
            local r = io.popen("cargo run --quiet")
            r:read("*a")
            r:close()
            --local cwd = lspconfig.util.find_git_ancestor(vim.fn.getcwd())
            local cwd = lspconfig.util.root_pattern('Cargo.toml')(vim.fn.getcwd())
            local handle = io.popen("cat "..cwd.."/Cargo.toml | rq -t | jq -r '.package.name'")
            local name = handle:read("*l")
            handle:close()
            return cwd .. "/target/debug/" .. name
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    }
}
------ hs
--stack install haskell-dap ghci-dap haskell-debug-adapter
dap.adapters.haskell = {
    type = 'executable';
    command = 'haskell-debug-adapter';
    args = {'--hackage-version=0.0.34.0'};
}
dap.configurations.haskell = {
    {
        type = 'haskell',
        request = 'launch',
        name = 'Debug',
        workspace = '${workspaceFolder}',
        startup = "${file}",
        stopOnEntry = true,
        logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
        logLevel = 'WARNING',
        ghciEnv = { wtf = "a lua dict" },
        ghciPrompt = "=| ",
        -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
        ghciInitialPrompt = "=| ",
        ghciCmd= "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
    },
}

------ js
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
    {
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
}

------ go
--go get -u github.com/go-delve/delve/cmd/dlv
dap.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err =
    vim.loop.spawn(
    "dlv",
    {
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
    },
    function(code)
        handle:close()
        print("Delve exited with exit code: " .. code)
    end
    )
    -- Wait 100ms for delve to start
    vim.defer_fn(
    function()
        --dap.repl.open()
        callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100)
    --callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}"
    }
}

------ php
--[[
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.remote_handler=dbgp
xdebug.discover_client_host=true
xdebug.remote_port=9000
--]]
-- curl 'http://localhost/?XDEBUG_SESSION_START=xdebug'
dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/opt/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9000
    }
}

