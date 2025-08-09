local resession = require('resession')
local tbm = require('taberm')

resession.setup {
    options = {
        "binary",
        --"bufhidden",
        "buflisted",
        "cmdheight",
        "diff",
        "filetype",
        "modifiable",
        "previewwindow",
        "readonly",
        "scrollbind",
        "winfixheight",
        "winfixwidth",
    },
    extensions = {
        quickfix = {},
        colorscheme = {},
    }
}

local nfy = function(x) require('notify').notify(vim.inspect(x)) end

local load = function()
    -- ignore: file gitcommit vimdiff ...
    if vim.fn.argc(-1) > 0 or vim.g.using_stdin then
        return
    end

    local cwd = vim.fn.getcwd()
    local wd = vim.fs.root(cwd, { '.git' }) or cwd

    if wd then
        local sn = vim.fn.substitute(wd, os.getenv('HOME'), '_', '')
        sn = vim.fn.substitute(sn, '/', '%', 'g')
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
vim.api.nvim_create_autocmd('StdinReadPre', {
  callback = function()
    -- Store this for later
    vim.g.using_stdin = true
  end,
})

-- Resession does NOTHING automagically, so we have to set up some keymaps
vim.keymap.set('n', '<leader>SS', resession.save)
vim.keymap.set('n', '<leader>SL', resession.load)
vim.keymap.set('n', '<leader>SD', resession.delete)

vim.api.nvim_create_user_command('SS', function(ctx) resession.save(ctx.args) end, { nargs = '?', complete = complete })
vim.api.nvim_create_user_command('SL', function(ctx) resession.load(ctx.args) end, { nargs = '?', complete = complete })
vim.api.nvim_create_user_command('SD', function(ctx) resession.delete(ctx.args) end, { nargs = '?', complete = complete })
