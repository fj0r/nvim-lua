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

function M.get_cursor_pos() return { vim.fn.line('.'), vim.fn.col('.') } end

function M.glob_exists(path) return vim.fn.empty(vim.fn.glob(path)) == 0 end



return M
