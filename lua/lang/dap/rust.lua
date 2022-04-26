local dap = require'dap'
local lspconfig = require'lspconfig'

--run docker with `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` or `--privileged`
local lldb_vscode_bin
for k, v in ipairs{14, 11} do
    lldb_vscode_bin = 'lldb-vscode-' .. v
    if vim.fn.executable(lldb_vscode_bin) == 1 then
        break
    end
end
dap.adapters.rust = {
    type = 'executable',
    command = lldb_vscode_bin,
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
