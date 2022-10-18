tele = require'telescope.builtin'
tele_tabby = require'telescope'.extensions.tele_tabby
local keymaps = {
    ['<leader>p']         = "<cmd>lua tele.pickers()<cr>",
    ['<leader>y']         = "<cmd>lua tele.lsp_document_symbols()<cr>",
    ['<leader>m']         = "<cmd>lua tele.marks()<cr>",
    ['<leader>d']         = "<cmd>lua tele.oldfiles()<cr>",
    ['<leader>f']         = "<cmd>lua tele.find_files()<cr>",
    ['<leader>r']         = "<cmd>lua tele.live_grep()<cr>",
    ['<leader>t']         = "<cmd>lua tele_tabby.list()<cr>",
    ['<leader>F']         = "<cmd>lua tele.git_files()<cr>",
    ['<leader>gc']        = "<cmd>lua tele.git_commits()<cr>",
    ['<leader>gb']        = "<cmd>lua tele.git_branches()<cr>",
    ['<leader>gs']        = "<cmd>lua tele.git_status()<cr>",
    ['<leader>go']        = "<cmd>lua tele.git_bcommits()<cr>",
    ['<leader>b']         = "<cmd>lua tele.buffers({show_all_buffers=false, ignore_current_buffer=true, sort_mru=true})<cr>",
    ['<leader>[']         = "<cmd>lua tele.builtin()<cr>",
    ['<leader>]']         = "<cmd>lua tele.help_tags()<cr>",
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

