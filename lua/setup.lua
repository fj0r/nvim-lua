local M = {}

local kmopt = function(str_or_tbl, desc)
    local o
    if type(str_or_tbl) == 'table' then
        o = str_or_tbl
    else
        o = {}
        for i = 1, #str_or_tbl do
            local k = string.sub(str_or_tbl, i, i)
            if k == 'n' then o.noremap = true end
            if k == 's' then o.silent = true end
            if k == 'e' then o.expr = true end
            if k == 'b' then o.buffer = true end
            if k == 'r' then o.remap = true end
        end
    end
    if desc then
        o.desc = desc
    end
    return o
end

function M.keymap_table(tbl)
    for _, km in ipairs(tbl) do
        if not km.disabled then
            local ms = km.mode or ''
            if type(ms) == 'table' then
                ms = table.concat(ms, '')
            end
            local opt = km[3] and kmopt(km[3], km.desc) or kmopt('ns', km.desc)
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

function M.option_table(tbl)
    for k, v in pairs(tbl) do
        if type(v) == 'table' then
            vim.opt[k]:append(v)
        else
            vim.o[k] = v
        end
    end
end

function M.global_table(tbl)
    for k, v in pairs(tbl) do
        vim.g[k] = v
    end
end

function M.mod(key, revert)
    local p

    p = vim.g.prefer_alt

    if revert then
        p = not p
    end

    if p then
        return "<M-" .. key .. ">"
    else
        if vim.g.prefer_alt > 1 then
            return "<M-S-" .. key .. ">"
        else
            return "<C-" .. key .. ">"
        end
    end
end

return M
