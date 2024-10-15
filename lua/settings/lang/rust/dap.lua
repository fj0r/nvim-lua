--run docker with `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` or `--privileged`

local dap = require 'dap'
local lspconfig = require 'lspconfig'
local lldb_vscode_bin
local lldb_version = io.popen("lldb -v 2>/dev/null | rg 'lldb version ([0-9]+)\\..*' -or '$1'")
if lldb_version ~= nil then
    local version = lldb_version:read()
    if version then
        lldb_vscode_bin = 'lldb-vscode-' .. version
    end
    lldb_version:close()
end

dap.adapters.lldb = {
    type = 'executable',
    command = lldb_vscode_bin,
    name = "lldb"
}

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
            --local cwd = lspconfig.util.find_git_ancestor(vim.fn.getcwd())
            local cwd = lspconfig.util.root_pattern('Cargo.toml')(vim.fn.getcwd())
            local handle = io.popen("cargo metadata --format-version=1 | jq -r '.packages[0].name'")
            if handle == nil then return end
            local name = handle:read("*l")
            handle:close()
            return cwd .. "/target/debug/" .. name
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        --postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
    }
}
