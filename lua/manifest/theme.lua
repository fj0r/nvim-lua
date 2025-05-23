local function set_theme(name, background)
    local theme = vim.fn.exists('$NVIM_THEME') and os.getenv('NVIM_THEME') or name
    local bg = background or 'dark'
    vim.opt.termguicolors = true
    vim.cmd('set background=' .. bg)
    vim.cmd.colorscheme(theme)
end

return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function(plugin)
            local c = require 'gruvbox'.load()
            require 'gruvbox'.setup {
                contrast = 'soft',
                dim_inactive = true,
                bold = false,
                palette_overrides = {
                },
                overrides = {
                    -- Substitute = { bg = "#9055a2", bold = true, fg = "#c8d3f5" },
                    -- WinSeparator = {},
                }
            }
            set_theme(plugin.name, "dark")
        end,
        enabled = false,
    },
    {
        "savq/melange-nvim",
        name = "melange",
        config = function(plugin)
            set_theme(plugin.name, "dark")
        end
    },
}
