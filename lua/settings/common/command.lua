vim.api.nvim_create_user_command('ClearReg', function()
    local regs = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, #regs do
        vim.fn.setreg(string.sub(regs, i, i), {})
    end
end, { nargs = '?', desc = 'clear register' })

vim.api.nvim_create_user_command('ClearMark', function()
    vim.api.nvim_command 'delmarks A-Z0-9'
end, { nargs = '?', desc = 'clear mark' })

vim.api.nvim_create_user_command('Detach', function()
    for _, i in ipairs(vim.api.nvim_list_uis()) do
        vim.fn.chanclose(i.chan)
    end
end, { nargs = '?', desc = 'Detach' })


local kill_tabpage = function()
    local t = vim.api.nvim_get_current_tabpage()
    local w = vim.api.nvim_tabpage_list_wins(t)
    for _, b in ipairs(w) do
        vim.api.nvim_buf_delete(vim.api.nvim_win_get_buf(b), { force = true })
    end
end
vim.api.nvim_create_user_command('TabpageQuit', kill_tabpage, { desc = 'close all window of the current tabpage' })

local close_except_last = function ()
    if #vim.api.nvim_list_wins() > 1 then
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
    end
end
vim.api.nvim_create_user_command('CloseExceptLast', close_except_last, { desc = 'close window except last one' })

if vim.g.server_mode then
    vim.api.nvim_command('command! -nargs=0  WQ :wall|Detach')
    vim.api.nvim_command('command! Q :Detach')
    vim.api.nvim_command('cabbrev q CloseExceptLast')
    vim.api.nvim_command('cabbrev qa Detach')
    vim.api.nvim_command('cabbrev qall Detach')
else
    vim.api.nvim_command('command! -nargs=0  WQ :wqall')
    vim.api.nvim_command('command! Q :qall')
end

vim.api.nvim_command('command! -nargs=0  W :wall')
vim.api.nvim_command('command! -nargs=0  Wq :wall|tabclose')
-- reload file
vim.api.nvim_command('command! -nargs=0  E :e!')

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "startuptime", "qf", "lspinfo" },
    command = [[nnoremap <buffer><silent> q :close<CR>]]
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "man",
    command = [[nnoremap <buffer><silent> q :quit<CR>]]
})
