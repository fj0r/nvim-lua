local function set_theme(name, background)
    local theme = vim.fn.exists('$NVIM_THEME') and os.getenv('NVIM_THEME') or name
    local bg = background or 'dark'
    vim.cmd('set background=' .. bg .. '|colorscheme ' .. theme)
end

return {
    {
        "luisiacc/gruvbox-baby",
        name = "gruvbox-baby",
        config = function(plugin)
            vim.g.gruvbox_baby_function_style = "NONE"
            vim.g.gruvbox_baby_background_color = 'medium' -- 'medium' | 'dark'
            vim.g.gruvbox_baby_telescope_theme = 0
            vim.g.gruvbox_baby_term_highlights = {
                "#282828", "#cc241d", "#98971a", "#d79921", "#458588", "#b16286", "#689d6a", "#ebdbb2",
                "#928374", "#fb4934", "#b8bb26", "#fabd2f", "#83a598", "#d3869b", "#8ec07c", "#a89984",
            }
            set_theme(plugin.name, "dark")
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        enabled = false,
        config = function(plugin)
            require 'gruvbox'.setup {
                contrast = '',
                palette_overrides = {
                },
                overrides = {
                    Substitute = { bg = "#9055a2", bold = true, fg = "#c8d3f5" }
                }
            }
            set_theme(plugin.name, "dark")
        end
    },
    {
        "savq/melange-nvim",
        name = "melange",
        config = function(plugin)
            --[[
            set_theme(plugin.name, "dark")
            --]]
        end
    },
}
