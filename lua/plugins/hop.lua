local hop = require('hop')

local override_opts = function(opts)
    return setmetatable(opts or {}, {
        __index = hop.opts,
    })
end

--local regex = vim.regex('\\k\\+')
local regex = vim.regex('\\v[a-zA-Z0-9]+|[,=#]+|[:;\\[\\]<>{}()]\\s*$|\\s+$')

local hint_somewhere = function(opts)
    local jump_target = require 'hop.jump_target'
    local hint_with = require("hop").hint_with

    opts = override_opts(opts)

    local generator
    if opts.current_line_only then
        generator = jump_target.jump_targets_for_current_line
    else
        generator = jump_target.jump_targets_by_scanning_lines
    end

    ---@diagnostic disable-next-line: need-check-nil
    hint_with(generator { oneshot = false, match = function(s) return regex:match_str(s) end }, opts)
end

require 'hop'.setup {
    -- keys = 'asdghklqwertyuiopzxcvbnmfj'
    keys = 'asdfjklqweruiopzxcv',
    -- keys = 'ajskdlf;quwieorpzxcv'
}

return {
    fns = {
        hint_somewhere = hint_somewhere,
        hint_lines = hop.hint_lines
    }
}
