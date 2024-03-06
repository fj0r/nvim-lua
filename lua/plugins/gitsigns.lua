require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', 'g[', function()
            if vim.wo.diff then return 'g[' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'Gitsigns next_hunk' })

        map('n', 'g]', function()
            if vim.wo.diff then return 'g]' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'Gitsigns prev_hunk' })
        map('n', 'gp', gs.preview_hunk, { desc = 'Gitsigns preview_hunk' })

        -- Actions
        map({ 'n', 'x' }, 'gh', ':Gitsigns stage_hunk<CR>', { desc = 'Gitsigns stage_hunk' })
        map({ 'n', 'x' }, 'gH', ':Gitsigns reset_hunk<CR>', { desc = 'Gitsigns reset_hunk' })
        map('n', 'gX', gs.undo_stage_hunk, { desc = 'Gitsigns undo_stage_hunk' })
        map('n', 'gs', gs.stage_buffer, { desc = 'Gitsigns stage_buffer' })
        map('n', 'gS', gs.reset_buffer, { desc = 'Gitsigns reset_buffer' })
        map('n', 'gl', function() gs.blame_line { full = true } end, { desc = 'Gitsigns blame_line' })
        map('n', 'gL', gs.toggle_current_line_blame, { desc = 'Gitsigns toggle_current_line_blame' })
        map('n', 'gm', gs.diffthis, { desc = 'Gitsigns diffthis' })
        map('n', 'gM', function() gs.diffthis('~') end, { desc = 'Gitsigns diff' })
        map('n', 'gP', gs.toggle_deleted, { desc = 'Gitsigns toggle_deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
