local M = {}
-- Get information about highlight group
function M.hl_by_name(hl_group)
    local hl = vim.api.nvim_get_hl_by_name(hl_group, true)
    if hl.foreground ~= nil then hl.fg = sprintf('#%x', hl.foreground) end
    if hl.background ~= nil then hl.bg = sprintf('#%x', hl.background) end
    return hl
end

-- Define a new highlight group
-- TODO: rewrite to `nvim_set_hl()` when API will be stable
function M.highlight(cfg)
    local command = 'highlight'
    if cfg.bang == true then command = command .. '!' end
    if #cfg == 2 and type(cfg[1]) == 'string' and type(cfg[2]) == 'string' then
        -- :highlight link
        command = command .. ' link ' .. cfg[1] .. ' ' .. cfg[2]
        vim.cmd(command)
        return
    end
    local guifg = cfg.fg or cfg.guifg or cfg[2]
    local guibg = cfg.bg or cfg.guibg or cfg[3]
    local gui = cfg.gui or cfg[4]
    local guisp = cfg.guisp or cfg[5]
    if type(cfg.override) == 'string' then
        local existing = vim.api.nvim_get_hl_by_name(cfg.override, true)
        if existing.foreground ~= nil then
            guifg = sprintf('#%x', existing.foreground)
        end
        if existing.background ~= nil then
            guibg = sprintf('#%x', existing.background)
        end
        if existing.special ~= nil then
            guibg = sprintf('#%x', existing.background)
        end
        if existing.undercurl == true then
            gui = 'undercurl'
        elseif existing.underline == true then
            gui = 'underline'
        end
    end
    command = command .. ' ' .. cfg[1]
    if guifg ~= nil then command = command .. ' guifg=' .. guifg end
    if guibg ~= nil then command = command .. ' guibg=' .. guibg end
    if gui ~= nil then command = command .. ' gui=' .. gui end
    if guisp ~= nil then command = command .. ' guisp=' .. guisp end
    vim.cmd(command)
end

function M.format_formatprg()
    local ok, formatprg = pcall(function() return vim.bo.formatprg end)
    if ok and #formatprg > 0 then
        local view = vim.fn.winsaveview()
        vim.cmd('normal gggqG')
        vim.fn.winrestview(view)
        return true
    end
    return false
end

return M
