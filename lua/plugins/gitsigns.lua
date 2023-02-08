if not vim.g.has_git then
    return
end

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    keymaps = {
        -- Default keymap options
        noremap = true,

        ['n g]'] = { expr = true, "&diff ? 'g]' : '<cmd>Gitsigns next_hunk<CR>'"},
        ['n g['] = { expr = true, "&diff ? 'g[' : '<cmd>Gitsigns prev_hunk<CR>'"},

        ['n ghs'] = '<cmd>Gitsigns stage_hunk<CR>',
        ['v ghs'] = ':Gitsigns stage_hunk<CR>',
        ['n ghu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
        ['n ghr'] = '<cmd>Gitsigns reset_hunk<CR>',
        ['v ghr'] = ':Gitsigns reset_hunk<CR>',
        ['n gR'] = '<cmd>Gitsigns reset_buffer<CR>',
        ['n gp'] = '<cmd>Gitsigns preview_hunk<CR>',
        ['n gb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
        ['n gS'] = '<cmd>Gitsigns stage_buffer<CR>',
        ['n gU'] = '<cmd>Gitsigns reset_buffer_index<CR>',


        -- Text objects
        ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
        ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
    },
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },
}
