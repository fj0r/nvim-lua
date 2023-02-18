local M = {}

local plugins = {}
for _, i in ipairs(require("lazy").plugins()) do
    plugins[i.name] = true
end

function M.has_plugin(p)
    return plugins[p]
end

function M.all_plugin()
    return plugins
end

local o = { silent = true, noremap = true }
function M.apply_keymap(plugin, opt)
    opt = opt or { fns = {} }
    for _, k in ipairs(plugin.keys) do
        local lo = k.desc and { silent = true, noremap = true, desc = k.desc} or o
        vim.keymap.set(k.mode or opt.mode or 'n', k[1], opt.fns[k[2]] or k[2], lo)
    end
end

return M
