local h = require('lazy_helper')

return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        enabled = vim.g.nvim_level >= 2,
    },
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        enabled = vim.g.nvim_level >= 3,
    },
    {
        "nvim-neorg/neorg",
        --build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = h.settings 'neorg',
        enabled = false
    },
    {
        'nvim-orgmode/orgmode',
        keys = {
            { '<leader>oa', nil, desc = 'orgmode agenda' },
            { '<leader>oc', nil, desc = 'orgmode capture' },
        },
        ft = { 'org' },
        config = h.settings 'orgmode',
        enabled = false,
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            {
                'kristijanhusak/vim-dadbod-completion',
                ft = { 'sql', 'mysql', 'plsql' },
                lazy = true
            },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "sql,mysql,plsql",
                callback = function()
                    require('cmp').setup.buffer {
                        sources = {
                            { name = 'vim-dadbod-completion' }
                        }
                    }
                end
            })
        end,
    },
    {
        'towolf/vim-helm',
        enabled = vim.g.nvim_level >= 3,
    }
}
