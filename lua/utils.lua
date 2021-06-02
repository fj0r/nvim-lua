local M = {}

function M.which (name)
    local f = io.popen('which '..name)
    local r = (f:read())
    f:close()
    return r or vim.o.shell
end

function M.dump(...)
    local args = {...}
    if #args == 1 then
        print(vim.inspect(args[1]))
    else
        print(vim.inspect(args))
    end
end

function M.dump_all(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function printf(...) print(string.format(...)) end
local sprintf = string.format
local function cmdf(...) vim.cmd(sprintf(...)) end

M.printf = printf
M.sprintf = sprintf
M.cmdf = cmdf

function M.get_cursor_pos() return {vim.fn.line('.'), vim.fn.col('.')} end

function M.debounce(func, timeout)
    local timer_id
    return function(...)
        if timer_id ~= nil then vim.fn.timer_stop(timer_id) end
        local args = {...}
        local function cb()
            func(args)
            timer_id = nil
        end
        timer_id = vim.fn.timer_start(timeout, cb)
    end
end

-- FIXME
function M.throttle(func, timeout)
    local timer_id
    local did_call = false
    return function(...)
        local args = {...}
        if timer_id == nil then
            func(args)
            local function cb()
                timer_id = nil
                if did_call then
                    func(args)
                    did_call = false
                end
            end
            timer_id = vim.fn.timer_start(timeout, cb)
        else
            did_call = true
        end
    end
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


function M.load(path)
    local ok, mod = pcall(require, path)
    if not ok then
        printf('Error loading module `%s`', path)
        print(mod)
    else
        local loadfunc
        if type(mod) == 'function' then
            loadfunc = mod
        elseif mod.setup ~= nil then
            loadfunc = mod.setup
        end
        local ok, err = pcall(loadfunc)
        if not ok then
            printf('Error loading module `%s`', path)
            print(err)
        end
    end
end

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

local autocmd_fn_index = 0

-- WIP:
function M.autocmd(event_name, pattern, callback)
    local fn_name = 'lua_autocmd' .. autocmd_fn_index
    autocmd_fn_index = autocmd_fn_index + 1
    _G[fn_name] = callback
    cmdf('autocmd %s %s call v:lua.%s()', event_name, pattern, fn_name)
end

function M.glob_exists(path) return vim.fn.empty(vim.fn.glob(path)) == 0 end

return M
