local gl = require 'galaxyline'
local fileinfo = require 'galaxyline.provider_fileinfo'
local vcs = require'galaxyline.provider_vcs'
local lspclient = require('galaxyline.provider_lsp')
local condition = require('galaxyline.condition')
local utils = require 'addons.galaxyline.utils'
local cl = require 'addons.galaxyline.colors16'.from_base16(vim.g.BASE16_THEME)

local gls = gl.section
local u = utils.u

local mode_map = {
    ['n'] = {'NORMAL', cl.normal},
    ['i'] = {'INSERT', cl.insert},
    ['R'] = {'REPLACE', cl.replace},
    ['v'] = {'VISUAL', cl.visual},
    ['V'] = {'V-LINE', cl.visual},
    ['c'] = {'COMMAND', cl.command},
    ['s'] = {'SELECT', cl.visual},
    ['S'] = {'S-LINE', cl.visual},
    ['t'] = {'TERMINAL', cl.terminal},
    [''] = {'V-BLOCK', cl.visual},
    [''] = {'S-BLOCK', cl.visual},
    ['Rv'] = {'VIRTUAL'},
    ['rm'] = {'--MORE'},
}

local sep = {
    --right_filled = u '2590',
    --left_filled = u '258c',
    right_filled = u 'e0b2',
    left_filled = u 'e0b0',
    -- right = u '2503',
    -- left = u '2503',
    right = u 'e0b3',
    left = u 'e0b1',
}

local icons = {
    locker = '',
    unsaved = '●',
    dos = u 'e70f',
    unix = u 'f17c',
    mac = u 'f179',
    lsp_warn = 'W',
    lsp_error = 'E',
}

local function mode_label() return mode_map[vim.fn.mode()][1] or 'N/A' end
local function mode_hl() return mode_map[vim.fn.mode()][2] or cl.none end

local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

local function buffer_not_empty()
    if vim.fn.empty(vim.fn.expand '%:t') ~= 1 then return true end
    return false
end

local function diagnostic_exists()
    return vim.tbl_isempty(vim.lsp.buf_get_clients(0))
end

local function wide_enough()
    local squeeze_width = vim.fn.winwidth(0)
    if squeeze_width > 80 then return true end
    return false
end

local function file_name()
    if not buffer_not_empty() then return '' end
    local fname
    if wide_enough() then
        fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
    else
        fname = vim.fn.expand '%:t'
    end
    if #fname == 0 then return '' end
    if vim.bo.readonly then
        fname = fname .. ' ' .. icons.locker
    end
    if vim.bo.modified then
        fname = fname .. ' ' .. icons.unsaved
    end
    return ' ' .. fname .. ' '
end

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'vimspector.Variables', 'vimspector.Watches', 'vimspector.StackTrace', 'vimspector.Console'}

gls.left = {
    {
        ViMode = {
            provider = function()
                local modehl = mode_hl()
                highlight('GalaxyViMode', cl.bg, modehl, 'bold')
                highlight('GalaxyViModeInv', modehl, cl.bg, 'bold')
                highlight('GalaxyViModeMid', cl.gradient, cl.bg, 'bold')
                highlight('GalaxyViModeMidInv', modehl, cl.gradient, 'bold')
                highlight('GalaxyViModeInvMid', cl.gradient, modehl, 'bold')
                return string.format('  %s ', mode_label())
            end,
            separator = sep.left,
            separator_highlight = 'GalaxyViMode',
        },
    }, {
        Paste = {
            provider = function()
                return vim.o.paste and ' paste ' or ''
            end,
            separator = sep.left_filled,
            highlight = 'GalaxyViMode',
            separator_highlight = 'GalaxyViModeMidInv',
        },
    }, {
        GitBranch = {
            provider = function ()
                local branch = vcs.get_git_branch()
                return branch and "  " .. vcs.get_git_branch() .. " " or ""
            end,
            separator = sep.left_filled,
            highlight = 'GalaxyViModeMidInv',
            separator_highlight = 'GalaxyViModeMid',
        },
    }, {
        FileName = {
            provider = file_name,
            highlight = {cl.fg, cl.bg},
            separator = sep.left,
            separator_highlight = 'GalaxyViModeInv',
        },
    },
}

gls.mid = {

}

gls.right = {
    {
        LspStatus = {
            provider = function()
                local connected =
                    not vim.tbl_isempty(vim.lsp.buf_get_clients(0))
                if connected then
                    return ' ' .. lspclient.get_lsp_client() .. ' '
                else
                    return ''
                end
            end,
            highlight = {cl.lsp_active, cl.bg},
            separator = sep.right,
            separator_highlight = 'GalaxyViModeInv',
        },
    }, {
        DiagnosticWarn = {
            provider = function()
                local n = vim.lsp.diagnostic.get_count(0, 'Warning')
                if n == 0 then return '' end
                return string.format(' %s %d ', icons.lsp_warn, n)
            end,
            highlight = {'yellow', cl.bg},
        },
        DiagnosticError = {
            provider = function()
                local n = vim.lsp.diagnostic.get_count(0, 'Error')
                if n == 0 then return '' end
                return string.format(' %s %d ', icons.lsp_error, n)
            end,
            highlight = {'red', cl.bg},
        },
    }, {
        FileType = {
            provider = function()
                if not buffer_not_empty() then return '' end
                if vim.bo.filetype == '' then return '' end
                return string.format(' %s ', vim.bo.filetype)
            end,
            condition = buffer_not_empty,
            separator = sep.right_filled,
            highlight = 'GalaxyViModeMidInv',
            separator_highlight = 'GalaxyViModeMid',
        },
    }, {
        FileFormat = {
            provider = function ()
                local format = fileinfo.get_file_format()
                local encode = fileinfo.get_file_encode()
                return encode .. '[' .. format .. '] '
            end,
            condition = buffer_not_empty,
            separator = sep.right,
            highlight = 'GalaxyViModeMidInv',
            separator_highlight = 'GalaxyViModeMidInv',
        },
    }, {
        PercentInfo = {
            provider = fileinfo.current_line_percent,
            highlight = 'GalaxyViMode',
            condition = buffer_not_empty,
            separator = sep.right_filled,
            separator_highlight = 'GalaxyViModeMidInv',
        },
    }, {
        PositionInfo = {
            provider = {
                function()
                    return string.format(
                        '%s:%s', vim.fn.line('.'), vim.fn.col('.')
                    )
                end,
            },
            highlight = 'GalaxyViMode',
            condition = buffer_not_empty,
            separator = sep.right,
            separator_highlight = 'GalaxyViMode',
        },
    },
}

table.insert(gls.short_line_right, {
    FileName = {
        provider = file_name,
        highlight = {cl.fg, cl.bg},
        separator = sep.right,
        separator_highlight = {cl.fg, cl.bg},
    },
})

