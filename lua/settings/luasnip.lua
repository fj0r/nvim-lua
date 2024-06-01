require("luasnip.loaders.from_vscode").lazy_load()
-- https://zjp-cn.github.io/neovim0.6-blogs/nvim/luasnip/doc1.html
require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.data_root .. "/snippets" })

----------------------
-- snippets/all.lua --
----------------------
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require "luasnip.extras.postfix".postfix

-- on the fly
local abs_otf_snip = function()
    local a = vim.fn.getpos('v')
    local b = vim.fn.getpos('.')
    local st = vim.fn.getregion(a, b, { type = vim.fn.visualmode() })
    vim.fn.setreg(vim.v.register, st)
    vim.api.nvim_buf_set_text(0, a[2]-1, a[3]-1, b[2]-1, b[3], {})
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>",
            true, false, true), "n", true)
    require('luasnip.extras.otf').on_the_fly(vim.v.register)
end

local app_otf_snip = function()
    require('luasnip.extras.otf').on_the_fly(vim.v.register)
end

vim.keymap.set('v', '<M-s>', abs_otf_snip, { noremap = true, silent = true })
vim.keymap.set({'n', 'i'}, '<M-s>', app_otf_snip, { noremap = true, silent = true })

ls.add_snippets("all", {
    s("ternary", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    })
})

ls.add_snippets("all", {
    s("trig6", c(1, {
        t("Ugh boring, a text node"),
        i(nil, "At least I can edit something now..."),
        f(function(args) return "Still only counts as text!!" end, {})
    }))
})
