local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local user_path = vim.fn.getenv("HOME").."/.local/bin/sumneko_lua"
local root_path = vim.fn.isdirectory(user_path) == 1
              and user_path
               or "/opt/language-server/sumneko_lua"

-- local templatedir = root_path..'/meta'
local exe = root_path .. "/bin/"..system_name.."/lua-language-server"
require"lspconfig".sumneko_lua.setup {
    cmd = { exe, "-E", root_path .. "/main.lua" };
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
}

