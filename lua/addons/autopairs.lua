local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local has_plugin = require'packer_helper'.has_plugin

local cfg = {
    disable_filetype = { "TelescopePrompt" , "vim" },
    fast_wrap = { },
}

if has_plugin'cmp' then
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

    -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
    cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
end


if has_plugin'nvim-treesitter' then
    cfg.check_ts = true
    cfg.ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
    npairs.setup(cfg)
    local ts_conds = require('nvim-autopairs.ts-conds')
    -- press % => %% only while inside a comment or string
    npairs.add_rules({
        Rule("%", "%", "lua")
        :with_pair(ts_conds.is_ts_node({'string','comment'})),
        Rule("$", "$", "lua")
        :with_pair(ts_conds.is_not_ts_node({'function'}))
    })
    require('nvim-treesitter.configs').setup {
        autotag = {
            enable = true
        }
    }
else
    npairs.setup(cfg)
end



local endwise = require('nvim-autopairs.ts-rule').endwise

npairs.add_rules({
    -- 'then$' is a lua regex
    -- 'end' is a match pair
    -- 'lua' is a filetype
    -- 'if_statement' is a treesitter name. set it = nil to skip check with treesitter
    endwise('then$', 'end', 'lua', 'if_statement')
})

