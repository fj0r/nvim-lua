local function set_theme(name)
    local theme = vim.fn.exists('$NVIM_THEME') and os.getenv('NVIM_THEME') or name
    vim.cmd('set background=dark|colorscheme ' .. theme)
end

return {
    {
        "savq/melange-nvim",
        config = function()
            set_theme('melange')
        end
    },
    {
        "sainnhe/sonokai",
        config = function(plugin)
            vim.g.sonokai_style = 'espresso' -- 'shusia'
            -- set_theme(plugin.name)
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require 'gruvbox'.setup {
                contrast = '',
                palette_overrides = {
                }
            }
            -- set_theme('gruvbox')
        end
    },

}
