local diag = {
    'diagnostics',
    symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
}
local lualine_b
if vim.fn.executable('git') > 0 then
    lualine_b = {'branch', 'diff', diag}
else
    lualine_b = {diag}
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = lualine_b,
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            }
        },
        lualine_x = {
            'encoding',
            {
                'fileformat',
                symbols = {unix = 'unix', dos = 'dos', mac = 'mac'}
            },
            'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
