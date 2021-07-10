local M = {}

function M.has_plugin(p)
    return packer_plugins[p] and packer_plugins[p].loaded
end

function M.config_with_plugin(t)
    local c = false
    for name, config in pairs(t) do
        if M.has_plugin(name) then
            config()
            c = true
        end
    end
    if not c and t['_'] then
        t['_']()
    end
end

return M
