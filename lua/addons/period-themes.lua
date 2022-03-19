local style_base16 = {
    midnight = 'base16-grayscale-dark',
    night = 'base16-chalk',
    twilight = 'base16-twilight',
    midday = 'base16-material-darker',
    day = 'base16-gruvbox-dark-hard',
}

local style_normal = {
    midnight = 'nightfox',
    night = 'nordfox',
    twilight = 'duskfox',
    midday = 'dawnfox',
    day = 'dayfox',
}

-- dark
local t = 'gruvbox-material'
local style = {
    midnight = t,
    night = t,
    twilight = t,
    midday = t,
    day = t,
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

local set_theme = function (theme)
    if theme == vim.g.THEME then
        return
    end
    vim.g.THEME = theme
    vim.cmd('colorscheme ' .. vim.g.THEME)
end

local get_week_theme = function ()
    local weekends = {
        [5] = true,
        [6] = true,
    }
    local is_weekend = weekends[tonumber(os.date("%w"))]
    if os.getenv('SHOW_SCHEDULE') then
        local hour = tonumber(os.date("%s")%24)
        local theme = get_theme(hour, is_weekend and night or morning )
        print(os.date("%s")%24 .. ' -> ' .. theme)
        return theme
    end
    local hour = tonumber(os.date("%H"))
    return get_theme(hour, is_weekend and night or morning )
end

local update_theme = function ()
    local timer = vim.loop.new_timer()
    local interval
    if os.getenv('SHOW_SCHEDULE') then
        interval = 1000
    else
        interval = 1 * 60 * 1000
    end
    timer:start(0, interval, vim.schedule_wrap(function()
        set_theme(get_week_theme())
    end))
end


local env_theme = os.getenv('NVIM_THEME')
if env_theme then
    set_theme(env_theme)
else
    set_theme(get_week_theme())
    update_theme()
end

