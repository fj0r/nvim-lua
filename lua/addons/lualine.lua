local gruvbox = vim.tbl_deep_extend('force', require('lualine.themes.gruvbox'), {
    terminal = {
        a = { bg = '#d79921', fg = '#282828', gui = 'bold' },
        b = { bg = '#504945', fg = '#ebdbb2' },
        c = { bg = '#7c6f64', fg = '#282828' },
    },
})

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
        theme = gruvbox,
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
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
                shorting_target = 40,
            }
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = { { 'tabs', mode = 2 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'buffers'},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {
        'neo-tree',
        'mundo',
        'nvim-dap-ui',
        'symbols-outline',
        'quickfix',
    }
}

vim.api.nvim_create_user_command('TabRename', function (info)
    vim.api.nvim_tabpage_set_var(vim.api.nvim_get_current_tabpage(), 'tabname', info.args)
end, { nargs = '?' })

vim.api.nvim_create_autocmd("DirChanged", {
    pattern = 'tabpage',
    callback = function (info)
        vim.g.aaa = info
        vim.api.nvim_tabpage_set_var(vim.api.nvim_get_current_tabpage(), 'tabname', info.file)
    end
})

