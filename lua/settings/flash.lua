local Flash = require('flash')
Flash.setup {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    jump = {
        autojump = true
    },
    label = {
        uppercase = false,
        rainbow = {
            enable = true,
            shade = 5
        }
    },
    modes = {
        char = {
            enabled = false
        },
        search = {
            enabled = true
        }
    },
}

local function format(opts)
    return {
        { opts.match.label1, "FlashMatch" },
        { opts.match.label2, "FlashLabel" },
    }
end

local mk2label = function(pattern)
    return function()
        Flash.jump({
            search = { mode = "search", multi_window = true },
            label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
            pattern = pattern,
            action = function(match, state)
                state:hide()
                Flash.jump({
                    search = { max_length = 0 },
                    highlight = { matches = false },
                    label = { format = format },
                    matcher = function(win)
                        -- limit matches to the current label
                        return vim.tbl_filter(function(m)
                            return m.label == match.label and m.win == win
                        end, state.results)
                    end,
                    labeler = function(matches)
                        for _, m in ipairs(matches) do
                            m.label = m.label2 -- use the second label
                        end
                    end,
                })
            end,
            labeler = function(matches, state)
                local labels = state:labels()
                for m, match in ipairs(matches) do
                    match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                    match.label2 = labels[(m - 1) % #labels + 1]
                    match.label = match.label1
                end
            end,
        })
    end
end

local km = {
    search = function() require("flash").jump() end,
    treesitter = function() require("flash").treesitter() end,
    remote = function() require("flash").remote() end,
    treesitter_search = function() require("flash").treesitter_search() end,
    toggle = function() require("flash").toggle() end,
    jump_to_line = mk2label([[^]]),
    -- any_word = mk2label('\\v[a-zA-Z0-9]+|[,=#]+|[:;\\[\\]<>{}()]\\s*$|\\s+$'),
    any_word = mk2label([[\<]]),
}

return {
    setup = function(plugin, ctx)
        ctx.apply_keymap(plugin.keys, km)
    end
}
