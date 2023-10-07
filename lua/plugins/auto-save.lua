require('auto-save').setup {
    condition = function(buf)
        local bn = vim.api.nvim_buf_get_name(buf)
        if string.sub(bn, 1, 5) == '/tmp/' then
            return false
        end

        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if 'gitcommit' == ft then
            return false
        end

        return true
    end
}
