return function ()
    --vim.g['sneak#streak'] = 1
    vim.g['sneak#label'] = 1
    --vim.g['sneak#target_labels'] = ";sftunq/SFGHLTUNRMQZ?0"
    vim.g['sneak#use_ic_scs'] = 1

    vim.api.nvim_set_keymap('', 'f', '<Plug>Sneak_f', {})
    vim.api.nvim_set_keymap('', 'F', '<Plug>Sneak_F', {})
    vim.api.nvim_set_keymap('', 't', '<Plug>Sneak_t', {})
    vim.api.nvim_set_keymap('', 'T', '<Plug>Sneak_T', {})
end
