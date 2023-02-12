local M = {}

function M.filter_files(path, pattern)
    local files = vim.fn.split(vim.fn.globpath(path, pattern), '\n')
    local index = 0
    local count = #files
    return function()
        index = index + 1
        if index <= count then
            return files[index]
        end
    end
end

function M.which(name)
    local f = io.popen('which ' .. name)
    if f == nil then return end
    local r = f:read()
    f:close()
    return r
end

function M.dump(...)
    local args = { ... }
    if #args == 1 then
        print(vim.inspect(args[1]))
    else
        print(vim.inspect(args))
    end
end

M.printf = function(...) print(string.format(...)) end
M.sprintf = string.format
M.cmdf = function(...) vim.cmd(M.sprintf(...)) end

function M.get_cursor_pos() return { vim.fn.line('.'), vim.fn.col('.') } end

function M.debounce(func, timeout)
    local timer_id
    return function(...)
        if timer_id ~= nil then vim.fn.timer_stop(timer_id) end
        local args = { ... }
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
        local args = { ... }
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

function M.glob_exists(path) return vim.fn.empty(vim.fn.glob(path)) == 0 end

return M
