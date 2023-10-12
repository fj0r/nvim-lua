require('auto-save').setup {
    condition = function(buf)
        if not vim.api.nvim_buf_is_valid(buf) then
            return false
        end

        local bn = vim.api.nvim_buf_get_name(buf)
        if string.sub(bn, 1, 5) == '/tmp/' then
            return false
        end
        -- file doesn't exist
        if vim.fn.filereadable(bn) == 0 then
            return false
        end

        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if 'gitcommit' == ft then
            return false
        end

        if not vim.api.nvim_buf_get_option(buf, 'modifiable') then
            return false
        end

        return true
    end
}
