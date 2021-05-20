local M = {}

function M.from_base16(name)
    local theme = require'base16'.themes[name]
    local base_indexes = {
        bg = 0x02,
        fg = 0x07,
        normal = 0x0B,
        insert = 0x0D,
        replace = 0x08,
        visual = 0x0A,
        command = 0x09,
        terminal = 0x0C,
        gradient = 0x03,
        error = 0x08,
        warn = 0x09,
        lsp_active = 0x0B,
        lsp_inactive = 0x08,
    }
    local colors = {}
    for key, index in pairs(base_indexes) do
        colors[key] = '#' .. theme['base' .. string.format('%02X', index)]
    end
    return colors
end

return M
