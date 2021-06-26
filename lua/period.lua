local style = {
    midnight = 'grayscale-dark',
    night = 'gruvbox-dark-hard',
    twilight = 'gruvbox-light-medium',
    midday = 'github',
    day = 'tomorrow',
}

local morning = {
    {4  , 'midnight'},
    {6  , 'night'},
    {9  , 'twilight'},
    {11 , 'day'},
    {15 , 'midday'},
    {19 , 'day'},
    {22 , 'twilight'},
    {24 , 'night'},
}

local night = {
    {2  , 'night'},
    {6  , 'midnight'},
    {8  , 'night'},
    {9  , 'twilight'},
    {11 , 'day'},
    {15 , 'midday'},
    {19 , 'day'},
    {24 , 'twilight'},
}

local get_theme = function(h, schedule)
    local theme
    for _, p in ipairs(schedule) do
        if h < p[1] then
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

