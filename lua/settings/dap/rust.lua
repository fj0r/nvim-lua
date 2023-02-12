local dap = require 'dap'
local lspconfig = require 'lspconfig'

--run docker with `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` or `--privileged`
local lldb_vscode_bin
for _, v in ipairs { 15, 14, 11 } do
    lldb_vscode_bin = 'lldb-vscode-' .. v
    if vim.fn.executable(lldb_vscode_bin) == 1 then
        break
    end
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
