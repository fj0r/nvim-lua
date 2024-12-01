require("codecompanion").setup {
    strategies = {
        chat = {
            adapter = "openai",
        },
        inline = {
            adapter = "openai",
        },
    },
    display = {
        diff = {
            provider = "mini_diff",
        },
    },
    opts = {
        log_level = "DEBUG",
    },
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
                    api_key = "cmd:echo $OpenAI_API_KEY", -- optional: if your endpoint is authenticated
                    chat_url = "/v1/chat/completions", -- optional: default value, override if different
                },
                schema = {
                    model = {
                        default = "qwen2.5-72b-instruct",
                    },
                },
            })
        end,
    },
}

vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
