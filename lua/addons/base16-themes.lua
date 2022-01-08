-- apprentice
-- chalk
-- darcula
-- espresso
-- horizon-dark
-- ia-dark
-- nord
-- woodland
-- ocean
-- nebula
-- pasque
-- railscasts
-- tomorrow-night
-- twilight
-- gruvbox-dark-hard
-- gruvbox-light-medium
-- black-metal-immortal
-- grayscale-dark

local style = {
    midnight = 'grayscale-dark',
    night = 'chalk',
    twilight = 'twilight',
    midday = 'material-darker',
    day = 'gruvbox-dark-hard',
}

local morning = {
    {0  , 'midnight'},
    {4  , 'night'},
    {6  , 'twilight'},
    {9  , 'day'},
    {11 , 'midday'},
    {15 , 'day'},
    {19 , 'twilight'},
    {22 , 'night'},
}

local night = {
    {0  , 'night'},
    {2  , 'midnight'},
    {6  , 'night'},
    {8  , 'twilight'},
    {9  , 'day'},
    {11 , 'midday'},
    {15 , 'day'},
    {19 , 'twilight'},
}

local get_theme = function(h, schedule)
    local theme
    for i = #schedule, 1, -1 do
        local p = schedule[i]
        if h >= p[1] then
            theme = style[p[2]]
            break
        end
    end
    return theme
end

if os.getenv('SHOW_SCHEDULE') then
    for i = 0, 23 do
        print(i .. ' ' .. get_theme(i, morning))
    end
end

vim.g.BASE16_THEME  = os.getenv('NVIM_THEME') or get_theme(tonumber(os.date("%H")), morning)

vim.cmd('colorscheme base16-' .. vim.g.BASE16_THEME)
