local function set_theme(name, background)
    local theme = vim.fn.exists('$NVIM_THEME') and os.getenv('NVIM_THEME') or name
    local bg = background or 'dark'
    vim.cmd('set background=' .. bg .. '|colorscheme ' .. theme)
end

return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function(plugin)
            --[[
            require 'gruvbox'.setup {
                contrast = '',
                palette_overrides = {
                },
                overrides = {
                    Substitute = { bg = "#9055a2", bold = true, fg = "#c8d3f5" }
                }
            }
            set_theme(plugin.name, "dark")
            --]]
        end
    },
    {
        "savq/melange-nvim",
        name = "melange",
        config = function(plugin)
            set_theme(plugin.name, "dark")
        end
    },
}
