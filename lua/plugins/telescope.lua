local tele = require 'telescope.builtin'
local tele_tabby = require 'telescope'.extensions.tele_tabby

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

return {
    pickers  = tele.pickers,
    lsp_document_symbols  = tele.lsp_document_symbols,
    marks  = tele.marks,
    oldfiles  = tele.oldfiles,
    find_files  = tele.find_files,
    live_grep  = tele.live_grep,
    tabs = tele_tabby.list,
    git_files  = tele.git_files,
    git_commits = tele.git_commits,
    git_branches = tele.git_branches,
    git_status = tele.git_status,
    git_bcommits = tele.git_bcommits,
    buffers  = function() tele.buffers({ show_all_buffers = false, ignore_current_buffer = true, sort_mru = true }) end,
    builtin  = tele.builtin,
    help_tags  = tele.help_tags,
}
