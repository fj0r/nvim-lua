if not vim.g.has_git then
    return
end

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- c lua nvim
-- bash markdown python
-- vim.version()
vim.g.treesitter_lang = {
    "css",
    "diff",
    "dockerfile",
    "go",
    "gomod",
    "graphql",
    "haskell",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "julia",
    "markdown",
    "php",
    "python",
    "regex",
    "rust",
    "toml",
    "typescript",
    "vue",
    "yaml"
}

if os.getenv('NVIM_MUSL') == '1' then
    -- apt install musl-dev musl-tools
    require 'nvim-treesitter.install'.compilers = { "musl-gcc" }
    require 'nvim-treesitter.parsers'.command_extra_args = { ["musl-gcc"] = { "-I/usr/include", "-static" } }
end

require 'nvim-treesitter.configs'.setup {
    ensure_installed = vim.g.treesitter_lang,
    sync_install = true,
    auto_install = false,
    indent = {
        enable = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    highlight = {
        enable = true,
        use_languagetree = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    textobjects = {
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["df"] = "@function.outer",
                ["dF"] = "@class.outer",
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ak"] = "@comment.outer",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["[S"] = "@parameter.inner",
            },
            swap_previous = {
                ["]S"] = "@parameter.inner",
            },
        },
    }
}
