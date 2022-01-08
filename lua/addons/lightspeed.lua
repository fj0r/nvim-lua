require'lightspeed'.setup {
    ignore_case = false,
    exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },

    -- s/x
    grey_out_search_area = true,
    highlight_unique_chars = true,
    jump_on_partial_input_safety_timeout = 400,
    match_only_the_start_of_same_char_seqs = true,
    substitute_chars = { ['\r'] = '¬' },
    -- Leaving the appropriate list empty effectively disables
    -- "smart" mode, and forces auto-jump to be on or off.
    safe_labels = {  },
    labels = {  },
    cycle_group_fwd_key = '<space>',
    cycle_group_bwd_key = '<tab>',

    -- f/t
    limit_ft_matches = 4,
    repeat_ft_with_target_char = false,
}
