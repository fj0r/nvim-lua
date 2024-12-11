local m = require('setup').mod
local tele = require 'telescope.builtin'
local tele_tabby = require 'telescope'.extensions.tele_tabby

local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')
telescope.setup {
    defaults = {
        borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
        cache_picker = {
            num_pickers = 100,
        },
        mappings = {
            i = {
                ["<c-x>"] = false,
                [m "s"] = actions.select_horizontal,
                [m "v"] = actions.select_vertical,
                [m "j"] = actions.move_selection_next,
                [m "k"] = actions.move_selection_previous,
                [m "q"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                [vim.g.mapesc or '<ESC>'] = actions.close,
                ["<CR>"] = actions.select_default + actions.center
                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                [m "j"] = actions.move_selection_next,
                [m "k"] = actions.move_selection_previous,
                [m "q"] = actions.smart_send_to_qflist + actions.open_qflist,
            }
        },
    },
    extensions = {
        --[[
        fzf = {
            fuzzy = true,                  -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        --]]
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
telescope.load_extension('emoji')
telescope.load_extension('env')
--[[
telescope.load_extension('fzf')
--]]

return {
    fns = {
        pickers              = tele.pickers,
        lsp_document_symbols = tele.lsp_document_symbols,
        marks                = tele.marks,
        registers            = tele.registers,
        oldfiles             = tele.oldfiles,
        find_files           = tele.find_files,
        live_grep            = tele.live_grep,
        tabs                 = tele_tabby.list,
        git_files            = tele.git_files,
        git_commits          = tele.git_commits,
        git_branches         = tele.git_branches,
        git_status           = tele.git_status,
        git_bcommits         = tele.git_bcommits,
        buffers              = function()
                                   tele.buffers({
                                       show_all_buffers = false,
                                       ignore_current_buffer = true,
                                       sort_mru = true
                                   })
                               end,
        builtin              = tele.builtin,
        help_tags            = tele.help_tags,
        notify               = function()
                                   telescope.extensions.notify.notify()
                               end,
    }
}
