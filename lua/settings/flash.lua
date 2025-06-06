local Flash = require('flash')
Flash.setup {
    labels = "asdfghjklqwertyuiopzxcvbnm[;",
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
    if opts.match.label2 then
        return {
            { opts.match.label1, "FlashMatch" },
            { opts.match.label2, "FlashLabel" },
        }
    else
        return {
            { opts.match.label1, "FlashLabel" },
        }
    end
end

local mk2label = function(pattern)
    return function()
        Flash.jump({
            search = { mode = "search", multi_window = true },
            label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
            pattern = pattern,
            action = function(match, state)
                if match.label2 then
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
                else
                    vim.api.nvim_win_set_cursor(match.win, match.pos)
                end
            end,
            labeler = function(matches, state)
                local labels = state:labels()
                local cur = vim.api.nvim_win_get_cursor(0)
                table.sort(matches, function(a, b)
                    if a.win ~= b.win then
                        local aw = a.win == state.win and 0 or a.win
                        local bw = b.win == state.win and 0 or b.win
                        return aw < bw
                    end
                    local da = math.abs(a.pos[1] - cur[1]) * 8 + math.abs(a.pos[2] - cur[2])
                    local db = math.abs(b.pos[1] - cur[1]) * 8 + math.abs(b.pos[2] - cur[2])
                    return da < db
                end)
                local cycle = math.ceil(#matches / #labels)
                local init = #labels - cycle
                for m, match in ipairs(matches) do
                    if m <= init then
                        match.label1 = labels[m]
                        match.label = match.label1
                    else
                        local ix = m - init - 1
                        match.label1 = labels[#labels - math.floor(ix / #labels)]
                        match.label2 = labels[ix % #labels + 1]
                        match.label = match.label1
                    end
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
