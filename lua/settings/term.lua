vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-N>]], { noremap = true, silent = true })
-- Pasting in terminal mode
vim.cmd [[tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi']]

local new_term = function (action, cmd)
    return function (ctx)
        vim.api.nvim_command(action)
        --vim.api.nvim_win_set_height(0, 10) -- set the window height
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_command('terminal '..cmd)
        vim.api.nvim_command('silent tcd! .')
        local chan = vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
        if ctx then
            vim.api.nvim_chan_send(chan, ctx.args..'\n')
        else
            vim.api.nvim_chan_send(chan, '')
        end
    end
end

local xnew  = new_term('tabnew', '')
local vnew  = new_term('rightbelow vnew', '')
local vxnew = new_term('botright vnew', '')
local cnew  = new_term('rightbelow new', '')
local cxnew = new_term('botright new', '')

vim.api.nvim_set_keymap('n', '<leader>xx', '', { callback = xnew,  noremap = true, silent = true, desc = 'new term tab' })
vim.api.nvim_set_keymap('n', '<leader>xv', '', { callback = vnew,  noremap = true, silent = true, desc = 'new term vertical' })
vim.api.nvim_set_keymap('n', '<leader>xV', '', { callback = vxnew, noremap = true, silent = true, desc = 'new term vertical ext' })
vim.api.nvim_set_keymap('n', '<leader>xc', '', { callback = cnew,  noremap = true, silent = true, desc = 'new term' })
vim.api.nvim_set_keymap('n', '<leader>xC', '', { callback = cxnew, noremap = true, silent = true, desc = 'new term ext' })

vim.api.nvim_create_user_command('X',  xnew,  { nargs = '?' , desc = 'new term tab'})
vim.api.nvim_create_user_command('V',  vnew,  { nargs = '?' , desc = 'new term vertical'})
vim.api.nvim_create_user_command('VX', vxnew, { nargs = '?' , desc = 'new term vertical ext'})
vim.api.nvim_create_user_command('C',  cnew,  { nargs = '?' , desc = 'new term'})
vim.api.nvim_create_user_command('CX', cxnew, { nargs = '?' , desc = 'new term ext'})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = 'term://*',
    callback = function ()
        local wo = vim.wo[vim.api.nvim_get_current_win()]
        wo.number = false
        wo.relativenumber = false
        wo.spell = false
        vim.api.nvim_command('startinsert')
    end
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = 'term://*',
    command = 'startinsert'
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = 'term://*',
    callback = function ()
        vim.api.nvim_input('<cr>')
    end
})

--[[ tcd hook
if 'NVIM' in (env).name {
    nvim --headless --noplugin --server $env.NVIM --remote-send $"<cmd>lua HookPwdChanged\('($after)', '($before)')<cr>"
}
--]]
function HookPwdChanged(after, before)
    vim.b.pwd = after

    local all_paths = { }
    for dir in vim.fs.parents(after) do
        table.insert(all_paths, dir)
    end

    local is_git = vim.fn.isdirectory(after.. "/.git") == 1
    local under_git
    if not is_git then
        for _, dir in ipairs(all_paths) do
            if vim.fn.isdirectory(dir .. "/.git") == 1 then
                under_git = dir
                break
            end
        end
    end
    -- require('notify').notify('cwd: '..after..', is_git: ' .. tostring(is_git).. ', under_git :'.. tostring(under_git),'info', {time = 1})
    if is_git or not under_git then
        vim.api.nvim_command('silent tcd! '..after)
    end
end

-- let b:pwd='($PWD)'
function OppositePwd()
    local tab = vim.api.nvim_get_current_tabpage()
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local cwin = vim.api.nvim_tabpage_get_win(tab)

    for _, w in ipairs(wins) do
        if cwin ~= w then
            local b = vim.api.nvim_win_get_buf(w)
            local pwd = vim.b[b].pwd
            if pwd then return pwd end
        end
    end
end

function ReadTempDrop(path, action)
    vim.api.nvim_command(action or 'botright vnew')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_command('read '..path)
    vim.fn.delete(path)
end
