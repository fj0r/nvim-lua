hop = require('hop')

local override_opts = function(opts)
    return setmetatable(opts or {}, {
        __index = hop.opts,
    })
end

--local regex = vim.regex('\\k\\+')
local regex = vim.regex('\\v[a-zA-Z0-9]+|[,=#]+|[:;\\[\\]<>{}()]\\s*$|\\s+$')

function hint_somewhere(opts)
    local jump_target = require'hop.jump_target'
    local hint_with = require("hop").hint_with

    opts = override_opts(opts)

    local generator
    if opts.current_line_only then
        generator = jump_target.jump_targets_for_current_line
    else
        generator = jump_target.jump_targets_by_scanning_lines
    end

    hint_with(generator{ oneshot = false, match = function(s) return regex:match_str(s) end }, opts)
end

local m = vim.api.nvim_set_keymap
for _, o in ipairs({'n', 'v', 'x'}) do
    m(o, 's', "<cmd>lua hint_somewhere()<cr>", {})
    --m(o, 's', "<cmd>lua require'hop'.hint_words()<cr>", {})
    --m(o, 'F', "<cmd>lua hop.hint_lines_skip_whitespace()<cr>", {})
    --m(o, '<C-s>', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})
    m(o, '<leader>s', "<cmd>lua hop.hint_char1()<cr>", {})
    m(o, 'S', "<cmd>lua require'hop'.hint_lines()<cr>", {})
    --m(o, '<leader>z', "<cmd>lua require'hop'.hint_char2()<cr>", {})
    --m(o, '<leader>p', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
end

require'hop'.setup {
    -- keys = 'asdghklqwertyuiopzxcvbnmfj'
    keys = 'asdfjklqweruiopzxcv',
    -- keys = 'ajskdlf;quwieorpzxcv'
}


