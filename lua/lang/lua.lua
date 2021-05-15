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

-- local sumneko_root_path = vim.fn.getenv("HOME").."/.local/bin/sumneko_lua"
local sumneko_root_path = "/opt/language-server/sumneko_lua"
require"lspconfig".sumneko_lua.setup {
  cmd = { sumneko_root_path .. "/bin/"..system_name.."/lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
  settings = {
      Lua = {
          runtime = {
              -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
          },
          workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                  [vim.fn.expand('/opt/openresty/lualib')] = true,
              },
          },
      },
  },
}

