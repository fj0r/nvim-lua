local m   = vim.api.nvim_set_keymap
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

m('i', '<M-1>', '<cmd>tabn 1<cr>', op2)
m('i', '<M-2>', '<cmd>tabn 2<cr>', op2)
m('i', '<M-3>', '<cmd>tabn 3<cr>', op2)
m('i', '<M-4>', '<cmd>tabn 4<cr>', op2)
m('i', '<M-5>', '<cmd>tabn 5<cr>', op2)
m('i', '<M-6>', '<cmd>tabn 6<cr>', op2)
m('i', '<M-7>', '<cmd>tabn 7<cr>', op2)
m('i', '<M-8>', '<cmd>tabn 8<cr>', op2)
m('i', '<M-9>', '<cmd>tabn 9<cr>', op2)
m('i', '<M-0>', '<cmd>tablast<cr>', op2)

m('t', '<M-1>', '<cmd>tabn 1<cr>', op2)
m('t', '<M-2>', '<cmd>tabn 2<cr>', op2)
m('t', '<M-3>', '<cmd>tabn 3<cr>', op2)
m('t', '<M-4>', '<cmd>tabn 4<cr>', op2)
m('t', '<M-5>', '<cmd>tabn 5<cr>', op2)
m('t', '<M-6>', '<cmd>tabn 6<cr>', op2)
m('t', '<M-7>', '<cmd>tabn 7<cr>', op2)
m('t', '<M-8>', '<cmd>tabn 8<cr>', op2)
m('t', '<M-9>', '<cmd>tabn 9<cr>', op2)
m('t', '<M-0>', '<cmd>tablast<cr>', op2)

------ window switching
m('', '<C-j>', '<C-W>j', op2)
m('', '<C-k>', '<C-W>k', op2)
m('', '<C-h>', '<C-W>h', op2)
m('', '<C-l>', '<C-W>l', op2)

m('i', '<C-j>', '<cmd>wincmd j<cr>', op2)
m('i', '<C-k>', '<cmd>wincmd k<cr>', op2)
m('i', '<C-h>', '<cmd>wincmd h<cr>', op2)
m('i', '<C-l>', '<cmd>wincmd l<cr>', op2)

m('t', '<C-j>', '<cmd>wincmd j<cr>', op2)
m('t', '<C-k>', '<cmd>wincmd k<cr>', op2)
m('t', '<C-h>', '<cmd>wincmd h<cr>', op2)
m('t', '<C-l>', '<cmd>wincmd l<cr>', op2)

------ window motion
m('', '<C-S-j>', '<C-W><S-j>', op2)
m('', '<C-S-k>', '<C-W><S-k>', op2)
m('', '<C-S-h>', '<C-W><S-h>', op2)
m('', '<C-S-l>', '<C-W><S-l>', op2)

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

m('', '<M-w>', '', { noremap = true, silent = true,
    callback = function ()
        resize_window_by_grid(vim.api.nvim_get_current_win(), vim.v.count)
    end
})
m('', '<M-h>', '', { noremap = true, silent = true,
    callback = function ()
        resize_window_by_grid(vim.api.nvim_get_current_win(), vim.v.count * 10)
    end
})
