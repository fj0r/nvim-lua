local gruvbox = vim.tbl_deep_extend('force', require('lualine.themes.gruvbox'), {
    terminal = {
        a = { bg = '#d79921', fg = '#282828', gui = 'bold' },
        b = { bg = '#504945', fg = '#ebdbb2' },
        c = { bg = '#7c6f64', fg = '#282828' },
    },
})

local diag = { 'diagnostics', symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'} }
local lualine_b = vim.fn.executable('git') > 0 and { 'branch', 'diff', diag } or { diag }

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
        lualine_a = {
            'diff',
            diag,
            {
                'filename',
                file_status = true,
                path = 1,
                shorting_target = 40,
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'progress', 'location'}
    },
    tabline = {
        lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns / 1.5 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'overseer'},
        lualine_y = {},
        lualine_z = {'windows'}
    },
    extensions = {
        'neo-tree',
        'mundo',
        'nvim-dap-ui',
        'symbols-outline',
        'quickfix',
        'overseer',
    }
}

local pin = '#'
local set_current_tabname = function (name)
    vim.t[vim.api.nvim_get_current_tabpage()].tabname = pin..name
end

local kb_prompt_rename_tab = {
    noremap = true, silent = true, desc = 'rename tab',
    callback = function ()
        local x = vim.fn.input('rename tab: ', '')
        set_current_tabname(x)
    end
}

vim.api.nvim_set_keymap('',  '<M-r>', '', kb_prompt_rename_tab)
vim.api.nvim_set_keymap('i', '<M-r>', '', kb_prompt_rename_tab)
vim.api.nvim_set_keymap('t', '<M-r>', '', kb_prompt_rename_tab)

vim.api.nvim_create_user_command('TabRename', function (ctx) set_current_tabname(ctx.args) end, { nargs = '?' })

vim.api.nvim_create_autocmd("DirChanged", {
    pattern = 'tabpage',
    callback = function (ctx)
        local tx = vim.api.nvim_get_current_tabpage()
        local tn = vim.t[tx].tabname
        if tn and string.sub(tn, 1, 1) == pin then return end

        local pn = vim.fn.substitute(ctx.file, os.getenv('HOME'), '~', '')
        vim.t[tx].tabname = pn
    end
})

