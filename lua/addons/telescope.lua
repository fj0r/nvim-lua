local keymaps = {
    ['<leader>f'] = "<cmd>lua require('telescope.builtin').find_files()<cr>",
    ['<leader>g'] = "<cmd>lua require('telescope.builtin').git_files()<cr>",
    ['<leader>r'] = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    ['<leader>b'] = "<cmd>lua require('telescope.builtin').buffers()<cr>",
    ['<leader>l'] = "<cmd>lua require('telescope').extensions.tele_tabby.list()<cr>",
    ['<leader>h'] = "<cmd>lua require('telescope.builtin').help_tags()<cr>",
    ['<leader>t'] = "<cmd>lua require('telescope').extensions.asynctasks.all()<cr>",
}

for k, v in pairs(keymaps) do
    vim.api.nvim_set_keymap('n', k, v, { noremap = true })
end


local actions = require('telescope.actions')
--local themes = require('telescope.themes')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<c-x>"] = false,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default + actions.center
                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            }
        },
    }
}

