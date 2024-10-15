vim.api.nvim_command [[
    set background=light
    colorscheme gruvbox
    au TermEnter * :set winhighlight=Normal:LightBg
    au BufHidden term://* :set winhighlight=Normal:Normal
]]
