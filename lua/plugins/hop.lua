hop = require('hop')
local has_plugin = require'lazy_helper'.has_plugin

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

local m = vim.keymap.set
if has_plugin'lightspeed.nvim' then
    for _, o in ipairs({'n', 'v', 'x'}) do
        m(o, '<leader><leader>', hint_somewhere, {})
        m(o, '<leader>;', hop.hint_lines, {})
    end
else
    for _, o in ipairs({'n', 'v', 'x'}) do
        m(o, ';', hint_somewhere, {})
        m(o, 's', hop.hint_char2, {})
        --m(o, 'F', "<cmd>lua hop.hint_lines_skip_whitespace()<cr>", {})
        --m(o, '<C-s>', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})
        m(o, ',', hop.hint_char1, {})
        m(o, '<leader>;', hop.hint_lines, {})
        --m(o, '<leader>z', "<cmd>lua require'hop'.hint_char2()<cr>", {})
        --m(o, '<leader>p', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
    end
end

require'hop'.setup {
    -- keys = 'asdghklqwertyuiopzxcvbnmfj'
    keys = 'asdfjklqweruiopzxcv',
    -- keys = 'ajskdlf;quwieorpzxcv'
}


