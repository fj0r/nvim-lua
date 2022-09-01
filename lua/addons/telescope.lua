local keymaps = {
    ['<leader>o']         = "<cmd>lua require('telescope.builtin').pickers()<cr>",
    ['<leader>y']         = "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
    ['<leader>m']         = "<cmd>lua require('telescope.builtin').marks()<cr>",
    ['<leader>d']         = "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
    ['<leader>f']         = "<cmd>lua require('telescope.builtin').find_files()<cr>",
    ['<leader>r']         = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    ['<leader>T']         = "<cmd>lua require('telescope').extensions.tele_tabby.list()<cr>",
    ['<leader>gf']        = "<cmd>lua require('telescope.builtin').git_files()<cr>",
    ['<leader>gc']        = "<cmd>lua require('telescope.builtin').git_commits()<cr>",
    ['<leader>gb']        = "<cmd>lua require('telescope.builtin').git_branches()<cr>",
    ['<leader>gs']        = "<cmd>lua require('telescope.builtin').git_status()<cr>",
    ['<leader>go']        = "<cmd>lua require('telescope.builtin').git_bcommits()<cr>",
    ['<leader>b']         = "<cmd>lua require('telescope.builtin').buffers()<cr>",
    ['<leader>[']         = "<cmd>lua require('telescope.builtin').builtin()<cr>",
    ['<leader>]']         = "<cmd>lua require('telescope.builtin').help_tags()<cr>",
}

for k, v in pairs(keymaps) do
    vim.api.nvim_set_keymap('n', k, v, { noremap = true })
end


local telescope = require('telescope')
local actions = require('telescope.actions')
--local themes = require('telescope.themes')
telescope.setup{
    defaults = {
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        cache_picker = {
            num_pickers = 100,
        },
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

telescope.load_extension("emoji")
telescope.load_extension('env')


