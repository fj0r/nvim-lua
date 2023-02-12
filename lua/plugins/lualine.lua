local gruvbox = vim.tbl_deep_extend('force', require('lualine.themes.gruvbox'), {
        terminal = {
            a = { bg = '#d79921', fg = '#282828', gui = 'bold' },
            b = { bg = '#504945', fg = '#ebdbb2' },
            c = { bg = '#7c6f64', fg = '#282828' },
        },
    })

local diag = { 'diagnostics', symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' } }

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
            'encoding',
            {
                'fileformat',
                symbols = { unix = 'unix', dos = 'dos', mac = 'mac' }
            },
            'filetype'
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
        lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns / 1.5 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'overseer' },
        lualine_y = {},
        lualine_z = { 'windows' }
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

local pin = '^'
local set_current_tabname = function(name)
    vim.t[vim.api.nvim_get_current_tabpage()].tabname = name == '' and '' or pin .. name
end

local kb_prompt_rename_tab = {
    noremap = true,
    silent = true,
    desc = 'rename tab',
    callback = function()
        local c = vim.v.count
        local p
        if c == 0 then
            local currname = vim.t[vim.api.nvim_get_current_tabpage()].tabname
            if currname and string.sub(currname, 1, 1) == pin then
                p = string.sub(currname, 2, #currname)
            else
                p = ''
            end
        else
            local parents = {}
            local cwd = vim.fn.getcwd()
            for pr in vim.fs.parents(cwd) do
                table.insert(parents, pr)
            end
            p = vim.fn.substitute(cwd, parents[c] .. '/', '', nil)
        end
        --local p = vim.fn.substitute(vim.fn.getcwd(), vim.fn.getenv('HOME'), '~', '')
        --local p = vim.fs.basename(vim.fn.getcwd())
        local x = vim.fn.input('rename tab: ', p)
        set_current_tabname(x)
        --[[
        vim.ui.input({ prompt = 'rename tab', default = p }, function (x)
            if not x then return end
            set_current_tabname(x)
        end)
        --]]
    end
}

vim.keymap.set('', '<M-r>', '', kb_prompt_rename_tab)
vim.keymap.set('i', '<M-r>', '', kb_prompt_rename_tab)
vim.keymap.set('t', '<M-r>', '', kb_prompt_rename_tab)

vim.api.nvim_create_user_command('TabRename', function(ctx) set_current_tabname(ctx.args) end, { nargs = '?' })

local vcs_root = require 'taberm.vcs'.root
vim.api.nvim_create_autocmd("DirChanged", {
    pattern = 'tabpage',
    callback = function(ctx)
        local curridx = vim.api.nvim_get_current_tabpage()
        local currname = vim.t[curridx].tabname
        if currname and string.sub(currname, 1, 1) == pin then return end

        local shortname = vim.fs.basename(ctx.file)
        local fullname = vim.fn.substitute(ctx.file, vim.fn.getenv('HOME'), '~', '')
        local name = shortname
        if not vcs_root(ctx.file, true) then
            name = fullname
        end
        vim.t[curridx].tabname = name
    end
})
