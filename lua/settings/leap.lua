require('leap').setup {
}


return {
    fns = {
        bi = function()
            require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
        end,
        all = function()
            local focusable_windows = vim.tbl_filter(
                function(win) return vim.api.nvim_win_get_config(win).focusable end,
                vim.api.nvim_tabpage_list_wins(0)
            )
            require('leap').leap { target_windows = focusable_windows }
        end,
        remote = function()
            local focusable_windows = vim.tbl_filter(
                function(win) return vim.api.nvim_win_get_config(win).focusable end,
                vim.api.nvim_tabpage_list_wins(0)
            )
            require('leap').leap {
                target_windows = focusable_windows,
                action = function(target)
                    local winid = target.wininfo.winid
                    local lnum, col = unpack(target.pos) -- 1/1-based indexing!
                    -- ... do something at the given position ...
                end,
            }
        end
    }
}
