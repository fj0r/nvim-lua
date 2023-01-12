local M = {}

local plugins = {}
for _, i in ipairs(require("lazy").plugins()) do
    plugins[i.name] = true
end

function M.has_plugin(p)
    return plugins[p]
end

return M
