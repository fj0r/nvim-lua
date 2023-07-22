local Flash = require('flash')
require 'flash'.setup {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    jump = {
        autojump = true
    },
    label = {
        uppercase = true,
        rainbow = {
            enable = true,
            shade = 5
        }
    },
}

local function format(opts)
    return {
        { opts.match.label1, "FlashMatch" },
        { opts.match.label2, "FlashLabel" },
    }
end


return {
    fns = {
        jump_to_line = function()
            require("flash").jump({
                search = { mode = "search", max_length = 0, multi_window = false },
                label = { after = { 0, 0 } },
                pattern = [[^]]
            })
        end,
        two_char = function()
            Flash.jump({
                search = { mode = "search" },
                label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
                pattern = [[\<]],
                action = function(match, state)
                    state:hide()
                    Flash.jump({
                        search = { max_length = 0 },
                        highlight = { matches = false },
                        label = { format = format },
                        matcher = function(win)
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
    }
}
