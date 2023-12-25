local resession = require('resession')
local vcs_root = require('lspconfig.util').root_pattern('.git/')
local tbm = require('taberm')

resession.setup()

local default_load = function()
    -- Only load the session if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
        -- Save these to a different directory, so our manual sessions don't get polluted
        resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
    end
end

local load = function()
    -- ignore: file gitcommit vimdiff ...
    -- local notify = function(x) require('notify').notify(vim.inspect(x)) end
    if vim.api.nvim_buf_get_name(0) ~= '' then
        return
    end
    -- if session_excluded() then return end

    local cwd = vim.fn.getcwd()
    local wd = vcs_root(cwd) or cwd

    if wd then
        local sn = vim.fn.substitute(wd, '/', '_', 'g')
        vim.g.resession_file = sn
        local exist = false
        for _, k in pairs(resession.list()) do
            if k == sn then
                exist = true
                break
            end
        end
        if exist then
            resession.load(sn)
        else
            resession.save(sn)
        end
    else
        tbm.n()
    end
end


local complete = function()
    local s = {}
    for _, v in pairs(resession.list()) do
        table.insert(s, v)
    end
    return s
end

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    nested = true,
    callback = load
})
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if vim.g.resession_file ~= nil then
            resession.save(vim.g.resession_file)
        end
    end,
})
-- Resession does NOTHING automagically, so we have to set up some keymaps
vim.keymap.set('n', '<leader>SS', resession.save)
vim.keymap.set('n', '<leader>SL', resession.load)
vim.keymap.set('n', '<leader>SD', resession.delete)

vim.api.nvim_create_user_command('SS', function(ctx) resession.save(ctx.args) end, { nargs = '?', complete = complete })
vim.api.nvim_create_user_command('SL', function(ctx) resession.load(ctx.args) end, { nargs = '?', complete = complete })
vim.api.nvim_create_user_command('SD', function(ctx) resession.delete(ctx.args) end, { nargs = '?', complete = complete })
