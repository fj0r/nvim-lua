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
    local r = handle:read("*a")
    local v = {}
    for l in string.gmatch(r, "[^\n]+") do
        table.insert(v, l)
    end
    handle:close()
    return v
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
            local names = cmd("cargo metadata --format-version=1 --no-deps | jq -r '.packages[].name'")
            local name
            if #names == 1 then
                name = names[1]
            else
                name = vim.fn.input("select bin ".. vim.inspect(names)..": ")
            end
            local cwd = cmd("cargo metadata --format-version=1 --no-deps | jq -r '.target_directory'")[1]
            cwd = cwd .. '/debug/' .. name
            print(cwd)
            return cwd
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        --postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
    }
}
