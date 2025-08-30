require("codecompanion").setup {
    opts = {
        log_level = "DEBUG", -- or "TRACE"
        language = "Chinese",
    },
    adapters = {
        http = {
            qwen3 = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        api_key = "QWEN_TOKEN",
                        url = "https://dashscope.aliyuncs.com/compatible-mode",
                        chat_url = "/v1/chat/completions",
                        models_endpoint = "/v1/models",
                    },
                    schema = {
                        model = {
                            default = "qwen3-coder-plus-2025-07-22",
                        },
                    },
                })
            end,
            glm45 = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        api_key = "GLM_TOKEN",
                        url = "https://open.bigmodel.cn/api/paas",
                        chat_url = "/v4/chat/completions",
                        models_endpoint = "/v4/models",
                    },
                    schema = {
                        model = {
                            default = "glm-4.5",
                        },
                    },
                })
            end,
        }
    },
    strategies = {
        chat = {
            adapter = "glm45",
        },
        inline = {
            adapter = "qwen3",
        },
        cmd = {
            adapter = "qwen3",
        },
    },
}
