local h = require('lazy_helper')
local function set_theme(name, background)
    local theme = os.getenv('NVIM_THEME') or name
    local bg = os.getenv('NVIM_LIGHT') == '1' and 'light' or background or 'dark'
    vim.opt.termguicolors = true
    vim.cmd('set background=' .. bg)
    vim.cmd.colorscheme(theme)
end

return {
    {
        "sainnhe/gruvbox-material",
        config = function(plugin)
            vim.g.gruvbox_material_background = 'medium'   -- hard, medium, soft
            vim.g.gruvbox_material_foreground = 'material' -- material, mix, original
            vim.g.gruvbox_material_better_performance = 1
            set_theme(plugin.name)
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = h.settings 'lualine',
        dependencies = {
            "sainnhe/gruvbox-material",
            {
                'kyazdani42/nvim-web-devicons',
                lazy = true
            }
        },
        enabled = vim.g.nvim_level >= 2,
    },
    {
        "savq/melange-nvim",
        name = "melange",
        config = function(plugin)
            -- set_theme(plugin.name, "dark")
        end
    },
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
            -- set_theme(plugin.name, "light")
        end,
        enabled = false,
    },
}
