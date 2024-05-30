vim.g.has_git = pcall(vim.fn.systemlist, { 'git', '--version' })


local level = 2

if vim.fn.exists('$NVIM_LEVEL') == 1 then
    level = tonumber(vim.fn.getenv('NVIM_LEVEL')) or 3
elseif vim.g.neovide then
    level = 3
elseif vim.g.vscode or vim.g.started_by_firenvim then
    level = 1
end

vim.g.nvim_level = level


local server_mode = false

for _, v in ipairs(vim.v.argv) do
    if v == '--listen' then
        server_mode = true
        break
    end
end

vim.g.server_mode = server_mode
