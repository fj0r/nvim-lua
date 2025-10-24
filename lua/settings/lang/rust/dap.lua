--run docker with `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` or `--privileged`

local dap = require 'dap'
local lldb_dap_bin = '/usr/bin/lldb-dap'

dap.adapters.lldb = {
    type = 'executable',
    command = lldb_dap_bin,
    name = "lldb"
}

local cmd = function(s)
    local handle = io.popen(s)
    if handle == nil then return end
    local r = handle:read("*l")
    handle:close()
    return r
end

dap.configurations.rust = {
    {
        name = "Launch",
        type = "lldb",
        request = 'launch',
        -- program = "${workspaceFolder}/target/debug/${file}"
        program = function()
            local r = io.popen("cargo build --quiet 2>/dev/null")
            if r == nil then return end
            local _ = r:read("*a")
            r:close()
            --local cwd = vim.fs.root(vim.fn.getcwd(), {'.git'})
            local name = cmd("cargo metadata --format-version=1 | jq -r '.packages[0].name'")
            local cwd = cmd("cargo metadata --format-version=1 | jq -r '.target_directory'")
            return cwd .. '/debug/' .. name
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        --postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
    }
}
