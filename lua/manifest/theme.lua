return {
    {
        "sainnhe/sonokai",
        config = function()
            vim.g.sonokai_style = 'espresso' -- 'shusia'
            vim.cmd 'set background=dark|colorscheme sonokai'
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
            -- vim.cmd 'set background=dark|colorscheme gruvbox'
            --require'plugins.period-themes'
        end
    },

}
