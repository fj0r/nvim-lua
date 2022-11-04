local m   = vim.api.nvim_set_keymap
local op1 = { noremap = true }
local op2 = { noremap = true, silent = true }

------ tab switching
m('', '<M-1>', '1gt', op2)
m('', '<M-2>', '2gt', op2)
m('', '<M-3>', '3gt', op2)
m('', '<M-4>', '4gt', op2)
m('', '<M-5>', '5gt', op2)
m('', '<M-6>', '6gt', op2)
m('', '<M-7>', '7gt', op2)
m('', '<M-8>', '8gt', op2)
m('', '<M-9>', '9gt', op2)
m('', '<M-0>', '<cmd>tablast<cr>', op2)

m('i', '<M-1>', '<cmd>silent! tabn 1<cr>', op1)
m('i', '<M-2>', '<cmd>silent! tabn 2<cr>', op1)
m('i', '<M-3>', '<cmd>silent! tabn 3<cr>', op1)
m('i', '<M-4>', '<cmd>silent! tabn 4<cr>', op1)
m('i', '<M-5>', '<cmd>silent! tabn 5<cr>', op1)
m('i', '<M-6>', '<cmd>silent! tabn 6<cr>', op1)
m('i', '<M-7>', '<cmd>silent! tabn 7<cr>', op1)
m('i', '<M-8>', '<cmd>silent! tabn 8<cr>', op1)
m('i', '<M-9>', '<cmd>silent! tabn 9<cr>', op1)
m('i', '<M-0>', '<cmd>silent! tablast<cr>', op1)

m('t', '<M-1>', '<cmd>silent! tabn 1<cr>', op1)
m('t', '<M-2>', '<cmd>silent! tabn 2<cr>', op1)
m('t', '<M-3>', '<cmd>silent! tabn 3<cr>', op1)
m('t', '<M-4>', '<cmd>silent! tabn 4<cr>', op1)
m('t', '<M-5>', '<cmd>silent! tabn 5<cr>', op1)
m('t', '<M-6>', '<cmd>silent! tabn 6<cr>', op1)
m('t', '<M-7>', '<cmd>silent! tabn 7<cr>', op1)
m('t', '<M-8>', '<cmd>silent! tabn 8<cr>', op1)
m('t', '<M-9>', '<cmd>silent! tabn 9<cr>', op1)
m('t', '<M-0>', '<cmd>silent! tablast<cr>', op1)

------ window switching
m('', '<C-j>', '<C-W>j', op2)
m('', '<C-k>', '<C-W>k', op2)
m('', '<C-h>', '<C-W>h', op2)
m('', '<C-l>', '<C-W>l', op2)

             -- '<cmd>wincmd j<cr>'
m('i', '<C-j>', "<C-\\><C-N><C-w>j", op2)
m('i', '<C-k>', "<C-\\><C-N><C-w>k", op2)
m('i', '<C-h>', "<C-\\><C-N><C-w>h", op2)
m('i', '<C-l>', "<C-\\><C-N><C-w>l", op2)

m('t', '<C-j>', "<C-\\><C-N><C-w>j", op2)
m('t', '<C-k>', "<C-\\><C-N><C-w>k", op2)
m('t', '<C-h>', "<C-\\><C-N><C-w>h", op2)
m('t', '<C-l>', "<C-\\><C-N><C-w>l", op2)

------ window motion
m('', '<M-j>', '<C-W><S-j>', op2)
m('', '<M-k>', '<C-W><S-k>', op2)
m('', '<M-h>', '<C-W><S-h>', op2)
m('', '<M-l>', '<C-W><S-l>', op2)

------ window resize
-- use double digits as arg. ones place for width, tens place for height
-- 0 for keep old, 9 for max, 1-8 for grid
local resize_window_by_grid = function (id, nn)
    local h = math.floor(nn/10)
    local w = nn - h*10
    local tw = w==0 and vim.api.nvim_win_get_width(id)
            or w==9 and vim.o.columns
            or math.floor(vim.o.columns * w / 8)
    local th = h==0 and vim.api.nvim_win_get_height(id)
            or h==9 and vim.o.lines
            or math.floor(vim.o.lines * h / 8)
    vim.api.nvim_win_set_width(id, tw)
    vim.api.nvim_win_set_height(id, th)
end

vim.api.nvim_create_user_command('WinResize',
    function (ctx)
        resize_window_by_grid(vim.api.nvim_get_current_win(), ctx.args)
    end,
    { nargs = '?' , desc = 'resize window by double digit'}
)

m('', '<leader>wh', '', { noremap = true, silent = true,
    desc = 'window resize horizontal',
    callback = function ()
        resize_window_by_grid(vim.api.nvim_get_current_win(), vim.v.count)
    end
})
m('', '<leader>wv', '', { noremap = true, silent = true,
    desc = 'window resize vertical',
    callback = function ()
        resize_window_by_grid(vim.api.nvim_get_current_win(), vim.v.count * 10)
    end
})
