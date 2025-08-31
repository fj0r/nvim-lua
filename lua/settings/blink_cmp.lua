local has_words_before = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

require('blink.cmp').setup {

    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
        preset = 'enter',
        -- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
        ['<Tab>'] = {
            function(cmp)
                if has_words_before() then
                    return cmp.insert_next()
                end
            end,
            'fallback',
        },
        -- Navigate to the previous suggestion or cancel completion if currently on the first one.
        ['<S-Tab>'] = { 'insert_prev' },
        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
    },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
    },

    completion = {
        menu = { enabled = true,
            draw = {
                columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                components = {
                    item_idx = {
                        text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
                        highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                    }
                }
            }
        },
        list = { selection = { preselect = true }, cycle = { from_top = false } },
        documentation = { auto_show = true }
    },

    signature = { enabled = true },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = {
        implementation = os.getenv('BLINK_CMP_RUST_FUZZY') and 'prefer_rust' or 'lua',
        prebuilt_binaries = { download = true, }
    },

    cmdline = {
        keymap = {
            preset = "cmdline",
        },
        completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
    }
}

local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config('*', {
    -- root_markers = { '.git', '.hg' },
    capabilities = capabilities,
})
