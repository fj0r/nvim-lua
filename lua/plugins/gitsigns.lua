require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'Gitsigns next_hunk' })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'Gitsigns prev_hunk' })

        -- Actions
        map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Gitsigns stage_hunk' })
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Gitsigns reset_hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Gitsigns stage_buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Gitsigns undo_stage_hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'Gitsigns reset_buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'Gitsigns preview_hunk' })
        map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = 'Gitsigns reset_hunk' })
        --map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Gitsigns toggle_current_line_blame' })
        --map('n', '<leader>hd', gs.diffthis, { desc = 'Gitsigns diffthis' })
        --map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Gitsigns diff' })
        --map('n', '<leader>hd', gs.toggle_deleted, { desc = 'Gitsigns toggle_deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
