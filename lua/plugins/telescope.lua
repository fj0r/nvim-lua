tele = require 'telescope.builtin'
tele_tabby = require 'telescope'.extensions.tele_tabby
local keymaps = {
    ['<leader>p']  = tele.pickers,
    ['<leader>y']  = tele.lsp_document_symbols,
    ['<leader>m']  = tele.marks,
    ['<leader>d']  = tele.oldfiles,
    ['<leader>f']  = tele.find_files,
    ['<leader>r']  = tele.live_grep,
    ['<leader>T']  = tele_tabby.list,
    ['<leader>F']  = tele.git_files,
    ['<leader>gc'] = tele.git_commits,
    ['<leader>gb'] = tele.git_branches,
    ['<leader>gs'] = tele.git_status,
    ['<leader>go'] = tele.git_bcommits,
    ['<leader>b']  = function() tele.buffers({ show_all_buffers = false, ignore_current_buffer = true, sort_mru = true }) end,
    ['<leader>[']  = tele.builtin,
    ['<leader>]']  = tele.help_tags,
}

for k, v in pairs(keymaps) do
    vim.keymap.set('n', k, v, { noremap = true })
end


local telescope = require('telescope')
local actions = require('telescope.actions')
--local themes = require('telescope.themes')
telescope.setup {
    defaults = {
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
                [vim.g.mapesc or '<ESC>'] = actions.close,
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
    },
    extensions = {
        aerial = {
            -- Display symbols as <root>.<parent>.<symbol>
            show_nesting = {
                ['_'] = false, -- This key will be the default
                json = true,   -- You can set the option for specific filetypes
                yaml = true,
            }
        }
    }
}

telescope.load_extension('aerial')
telescope.load_extension("emoji")
telescope.load_extension('env')
