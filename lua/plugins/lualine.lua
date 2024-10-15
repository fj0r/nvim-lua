local gruvbox = vim.tbl_deep_extend('force', require('lualine.themes.gruvbox'), {
    terminal = {
        a = { bg = '#d79921', fg = '#282828', gui = 'bold' },
        b = { bg = '#504945', fg = '#ebdbb2' },
        c = { bg = '#7c6f64', fg = '#282828' },
    },
})

local diag = { 'diagnostics', symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' } }

local macro_recording = function()
    local t = vim.fn.reg_recording()
    if t ~= '' then
        return 'recording @' .. t
    else
        return ''
    end
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = gruvbox,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = vim.g.has_git and { 'branch', 'diff', diag } or { diag },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            }
        },
        lualine_x = {
            {
                'fileformat',
                --symbols = { unix = 'unix', dos = 'dos', mac = 'mac' }
            },
            'encoding',
            'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = vim.g.has_git and { 'diff', diag } or { diag },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
                shorting_target = 40,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'progress', 'location' }
    },
    tabline = {
        lualine_a = {
            { 'tabs', mode = 2, max_length = function() return math.floor(vim.o.columns / 1.5) end }
        },
        lualine_b = { 'aerial' },
        lualine_c = {},
        lualine_x = {}, -- macro_recording
        lualine_y = { 'overseer' },
        lualine_z = {
            { 'windows', disabled_filetypes = vim.g.plugin_filetypes }
        }
    },
    extensions = {
        'neo-tree',
        'mundo',
        'nvim-dap-ui',
        'symbols-outline',
        'quickfix',
        'overseer',
        'aerial'
    }
}

local refresh_tabline = function()
    require('lualine').refresh {
        scope = 'all',
        place = { 'tabline' }
    }
end

vim.api.nvim_create_autocmd("VimResized", { callback = refresh_tabline })
vim.api.nvim_create_autocmd("RecordingEnter", { callback = refresh_tabline })
vim.api.nvim_create_autocmd("RecordingLeave", { callback = refresh_tabline })


local vcs_root = require('lspconfig.util').root_pattern('.git/')
vim.api.nvim_create_autocmd("DirChanged", {
    pattern = 'tabpage',
    callback = function(ctx)
        local curridx = vim.api.nvim_get_current_tabpage()
        local currname = vim.t[curridx].tabname
        if currname and string.sub(currname, 1, 1) == vim.g.tab_title_pin then return end

        local name = nil
        if vcs_root(ctx.file) then
            name = vim.fs.basename(ctx.file)
        else
            name = vim.fn.substitute(ctx.file, os.getenv('HOME'), '~', '')
        end
        vim.t[curridx].tabname = name
    end
})
