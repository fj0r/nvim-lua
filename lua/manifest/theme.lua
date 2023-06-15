local function set_theme(name)
    local theme = vim.fn.exists('$NVIM_THEME') and os.getenv('NVIM_THEME') or name
    vim.cmd('set background=dark|colorscheme ' .. theme)
end

return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function(plugin)
            require 'gruvbox'.setup {
                contrast = '',
                palette_overrides = {
                }
            }
            set_theme(plugin.name)
        end
    },
    {
        "savq/melange-nvim",
        name = "melange",
        config = function(plugin)
            -- set_theme(plugin.name)
        end
    },
    {
        "sainnhe/sonokai",
        config = function(plugin)
            vim.g.sonokai_style = 'espresso' -- 'shusia'
            -- set_theme(plugin.name)
        end
    },
}
