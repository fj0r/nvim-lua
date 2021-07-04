local keymaps = {
    ['<leader><space>'] = "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
    ['<leader>m'] = "<cmd>lua require('telescope.builtin').marks()<cr>",
    ['<leader>o'] = "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
    ['<leader>f'] = "<cmd>lua require('telescope.builtin').find_files()<cr>",
    ['<leader>g'] = "<cmd>lua require('telescope.builtin').git_files()<cr>",
    ['<leader>r'] = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    ['<leader>l'] = "<cmd>lua require('telescope').extensions.tele_tabby.list()<cr>",
    ['<leader>h'] = "<cmd>lua require('telescope.builtin').help_tags()<cr>",
    ['<leader>t'] = "<cmd>lua require('telescope').extensions.asynctasks.all()<cr>",
    ['<leader>c'] = "<cmd>lua require('telescope.builtin').git_commits()<cr>",
    ['<leader>b'] = "<cmd>lua require('telescope.builtin').git_branches()<cr>",
    --['<leader>s'] = "<cmd>lua require('telescope.builtin').git_status()<cr>",
    --['<leader>p'] = "<cmd>lua require('telescope.builtin').git_bcommits()<cr>",
    --['<leader><space>'] = "<cmd>lua require('telescope.builtin').buffers()<cr>",
    ['<leader>]'] = "<cmd>lua require('telescope.builtin').builtin()<cr>",
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

