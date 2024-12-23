local hop = require('hop')

local override_opts = function(opts)
    return setmetatable(opts or {}, {
        __index = hop.opts,
    })
end

--local regex = vim.regex('\\k\\+')
local regex = vim.regex('\\v[a-zA-Z0-9]+|[,=#]+|[:;\\[\\]<>{}()]\\s*$|\\s+$')

local hint_somewhere = function(opts)
    hop.hint_with_regex({
        oneshot = false,
        match = function(s) return regex:match_str(s) end,
    }, override_opts(opts))
end

require 'hop'.setup {
    -- keys = 'asdghklqwertyuiopzxcvbnmfj',
    -- keys = 'asdfjklqweruiopzxcv',
    keys = 'asdf;lkjqwerpoiuzxcv/.,m',
    -- perm_method = require'hop.perm'.TrieBacktrackFilling,
    multi_windows = true,
    term_seq_bias = 0.7
}

return {
    fns = {
        somewhere = hint_somewhere,
        lines = hop.hint_lines,
        words = hop.hint_words,
        char1 = hop.hint_char1,
    }
}
