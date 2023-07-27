local M = {}

local kopt = function(a, desc)
    local o = {}
    for i = 1, #a do
        local k = string.sub(a, i, i)
        if k == 'n' then o.noremap = true end
        if k == 's' then o.silent = true end
        if k == 'e' then o.expr = true end
    end
    if desc then
        o.desc = desc
    end
    return o
end

function M.keytables(tbls)
    for _, km in ipairs(tbls) do
        if not km.disabled then
            local ms = km.mode or ''
            local opt = km[3] and kopt(km[3], km.desc) or kopt('ns', km.desc)
            if ms == '' then
                vim.keymap.set('', km[1], km[2], opt)
            else
                for i = 1, #ms do
                    vim.keymap.set(string.sub(ms, i, i), km[1], km[2], opt)
                end
            end
        end
    end
end

return M
