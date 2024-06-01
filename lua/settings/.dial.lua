local m = vim.api.nvim_set_keymap
m('n', '<C-a>', '<Plug>(dial-increment)', {})
m('n', '<C-x>', '<Plug>(dial-decrement)', {})
m('v', '<C-a>', '<Plug>(dial-increment)', {})
m('v', '<C-x>', '<Plug>(dial-decrement)', {})
m('v', 'g<C-a>', '<Plug>(dial-increment-additional)', {})
m('v', 'g<C-x>', '<Plug>(dial-decrement-additional)', {})

local dial = require("dial")

table.insert(dial.config.searchlist.normal, "markup#markdown#header")

