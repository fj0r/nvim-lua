table.unpack = table.unpack or unpack

-- Shim: replace deprecated vim.tbl_flatten (removed in 0.13) with vim.iter API
if vim.tbl_flatten and not rawget(vim, '_tbl_flatten_shimmed') then
    local orig = vim.tbl_flatten
    vim.tbl_flatten = function(t, ...)
        return vim.iter(t):flatten(...):totable()
    end
    vim._tbl_flatten_shimmed = true
end
