require 'lightspeed'.setup {
    ignore_case = true,
    exit_after_idle_msecs = { unlabeled = nil, labeled = nil },

    -- s/x
    jump_to_unique_chars = { safety_timeout = 400 },
    match_only_the_start_of_same_char_seqs = true,
    force_beacons_into_match_width = false,
    -- Display characters in a custom way in the highlighted matches.
    substitute_chars = { ['\r'] = '¬' },
    -- Leaving the appropriate list empty effectively disables
    -- "smart" mode, and forces auto-jump to be on or off.
    --[[
    safe_labels = {
        "s", "f", "n",
        "u", "t", "/",
        "S", "F", "N", "L", "H", "M", "U", "G", "T", "?", "Z"
    } ,
    labels = {
        "s", "f", "n",
        "j", "k", "l", "h", "o", "d", "w", "e", "m", "b",
        "u", "y", "v", "r", "g", "t", "c", "x", "/", "z",
        "S", "F", "N",
        "J", "K", "L", "H", "O", "D", "W", "E", "M", "B",
        "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z"
    },
    --]]
    special_keys = {
        next_match_group = '<space>',
        prev_match_group = '<tab>'
    },
    -- f/t
    limit_ft_matches = 4,
    repeat_ft_with_target_char = false,
}
