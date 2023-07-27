local keytables = require('helper').keytables

keytables {
    ------ tab switching
    { '<leader>1', '1gt',                      'ns', mode = '' },
    { '<leader>2', '2gt',                      'ns', mode = '' },
    { '<leader>3', '3gt',                      'ns', mode = '' },
    { '<leader>4', '4gt',                      'ns', mode = '' },
    { '<leader>5', '5gt',                      'ns', mode = '' },
    { '<leader>6', '6gt',                      'ns', mode = '' },
    { '<leader>7', '7gt',                      'ns', mode = '' },
    { '<leader>8', '8gt',                      'ns', mode = '' },
    { '<leader>9', '9gt',                      'ns', mode = '' },
    { '<leader>0', '<cmd>tablast<cr>',         'ns', mode = '' },

    { '<M-1>',     '1gt',                      'ns', mode = '' },
    { '<M-2>',     '2gt',                      'ns', mode = '' },
    { '<M-3>',     '3gt',                      'ns', mode = '' },
    { '<M-4>',     '4gt',                      'ns', mode = '' },
    { '<M-5>',     '5gt',                      'ns', mode = '' },
    { '<M-6>',     '6gt',                      'ns', mode = '' },
    { '<M-7>',     '7gt',                      'ns', mode = '' },
    { '<M-8>',     '8gt',                      'ns', mode = '' },
    { '<M-9>',     '9gt',                      'ns', mode = '' },
    { '<M-0>',     '<cmd>tablast<cr>',         'ns', mode = '' },

    { '<M-1>',     '<cmd>silent! tabn 1<cr>',  'n',  mode = 'i' },
    { '<M-2>',     '<cmd>silent! tabn 2<cr>',  'n',  mode = 'i' },
    { '<M-3>',     '<cmd>silent! tabn 3<cr>',  'n',  mode = 'i' },
    { '<M-4>',     '<cmd>silent! tabn 4<cr>',  'n',  mode = 'i' },
    { '<M-5>',     '<cmd>silent! tabn 5<cr>',  'n',  mode = 'i' },
    { '<M-6>',     '<cmd>silent! tabn 6<cr>',  'n',  mode = 'i' },
    { '<M-7>',     '<cmd>silent! tabn 7<cr>',  'n',  mode = 'i' },
    { '<M-8>',     '<cmd>silent! tabn 8<cr>',  'n',  mode = 'i' },
    { '<M-9>',     '<cmd>silent! tabn 9<cr>',  'n',  mode = 'i' },
    { '<M-0>',     '<cmd>silent! tablast<cr>', 'n',  mode = 'i' },

    { '<M-1>',     '<cmd>silent! tabn 1<cr>',  'n',  mode = 't' },
    { '<M-2>',     '<cmd>silent! tabn 2<cr>',  'n',  mode = 't' },
    { '<M-3>',     '<cmd>silent! tabn 3<cr>',  'n',  mode = 't' },
    { '<M-4>',     '<cmd>silent! tabn 4<cr>',  'n',  mode = 't' },
    { '<M-5>',     '<cmd>silent! tabn 5<cr>',  'n',  mode = 't' },
    { '<M-6>',     '<cmd>silent! tabn 6<cr>',  'n',  mode = 't' },
    { '<M-7>',     '<cmd>silent! tabn 7<cr>',  'n',  mode = 't' },
    { '<M-8>',     '<cmd>silent! tabn 8<cr>',  'n',  mode = 't' },
    { '<M-9>',     '<cmd>silent! tabn 9<cr>',  'n',  mode = 't' },
    { '<M-0>',     '<cmd>silent! tablast<cr>', 'n',  mode = 't' },

    ------ window switching
    { '<C-j>',     '<C-W>j',                   'ns', mode = '' },
    { '<C-k>',     '<C-W>k',                   'ns', mode = '' },
    { '<C-h>',     '<C-W>h',                   'ns', mode = '' },
    { '<C-l>',     '<C-W>l',                   'ns', mode = '' },

    -- '<cmd>wincmd j<cr>'
    { '<C-j>',     "<C-\\><C-N><C-w>j",        'ns', mode = 'i' },
    { '<C-k>',     "<C-\\><C-N><C-w>k",        'ns', mode = 'i' },
    { '<C-h>',     "<C-\\><C-N><C-w>h",        'ns', mode = 'i' },
    { '<C-l>',     "<C-\\><C-N><C-w>l",        'ns', mode = 'i' },

    { '<C-j>',     "<C-\\><C-N><C-w>j",        'ns', mode = 't' },
    { '<C-k>',     "<C-\\><C-N><C-w>k",        'ns', mode = 't' },
    { '<C-h>',     "<C-\\><C-N><C-w>h",        'ns', mode = 't' },
    { '<C-l>',     "<C-\\><C-N><C-w>l",        'ns', mode = 't' },

    ------ window motion
    { '<M-j>',     '<C-W><S-j>',               'ns', mode = '' },
    { '<M-k>',     '<C-W><S-k>',               'ns', mode = '' },
    { '<M-h>',     '<C-W><S-h>',               'ns', mode = '' },
    { '<M-l>',     '<C-W><S-l>',               'ns', mode = '' },
}

------ window resize
-- use double digits as arg. ones place for width, tens place for height
-- 0 for keep old, 9 for max, 1-8 for grid
local resize_window_by_grid = function(id, nn)
    local h = math.floor(nn / 10)
    local w = nn - h * 10
    local tw = w == 0 and vim.api.nvim_win_get_width(id)
        or w == 9 and vim.o.columns
        or math.floor(vim.o.columns * w / 8)
    local th = h == 0 and vim.api.nvim_win_get_height(id)
        or h == 9 and vim.o.lines
        or math.floor(vim.o.lines * h / 8)
    vim.api.nvim_win_set_width(id, tw)
    vim.api.nvim_win_set_height(id, th)
end

vim.api.nvim_create_user_command('WinResize',
    function(ctx)
        resize_window_by_grid(vim.api.nvim_get_current_win(), ctx.args)
    end,
    { nargs = '?', desc = 'resize window by double digit' }
)

vim.keymap.set('', '<leader>wh',
    function()
        resize_window_by_grid(vim.api.nvim_get_current_win(), vim.v.count)
    end,
    { noremap = true, silent = true, desc = 'window resize horizontal' }
)

vim.keymap.set('', '<leader>wv',
    function()
        resize_window_by_grid(vim.api.nvim_get_current_win(), vim.v.count * 10)
    end,
    { noremap = true, silent = true, desc = 'window resize vertical' }
)
