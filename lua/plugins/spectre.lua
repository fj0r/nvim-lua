require'spectre'.setup {
    live_update = true,
    lnum_for_results = false, -- show line number for search/replace results
    line_sep_start = '-----------------------------------------',
    result_padding = '  ',
    line_sep       = '-----------------------------------------',
    mapping = {
        ['run_current_replace'] = {
          map = "ss",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line"
        },
    }
}

