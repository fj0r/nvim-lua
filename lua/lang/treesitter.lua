vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
local lans = {
    'bash', 'cpp', 'css', 'go', 'gomod', 'graphql',
    'html', 'java', 'javascript', 'jsdoc', 'json', 'jsonc', 'julia',
    'lua', 'php', 'python', 'regex', 'rust',
    'toml', 'tsx', 'typescript', 'vue', 'yaml'
}
require'nvim-treesitter.configs'.setup {
    ensure_installed = lans,
    indent = {
        enable = true
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
        use_languagetree = true
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
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["iF"] = {
                    python = "(function_definition) @function",
                    lua = "(function_definition) @function",
                    rust = "(function_definition) @function",
                    haskell = "(function_definition) @function",
                    go = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    java = "(method_declaration) @function",
                }
            }
        }
    }
}

