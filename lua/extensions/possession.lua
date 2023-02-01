local tbm = require('taberm')
local vcs_root = require'taberm.vcs'.root

require('possession').setup {
    session_dir = vim.g.data_root.."/possession",
    -- session_dir = (Path:new(vim.fn.stdpath('data')) / 'possession'):absolute(),
    silent = true,
    load_silent = true,
    debug = false,
    prompt_no_cr = false,
    autosave = {
        current = true,  -- or fun(name): boolean
        tmp = true,  -- or fun(): boolean
        tmp_name = 'tmp',
        on_load = true,
        on_quit = true,
    },
    commands = {
        -- 'PossessionXxx',
        save = 'Ssave',
        load = 'Sload',
        close = 'Sclose',
        delete = 'Sdelete',
        show = 'Sshow',
        list = 'Slist',
        migrate = 'Smigrate',
    },
    hooks = {
        before_save = function(name) return {} end,
        after_save = function(name, user_data, aborted) end,
        before_load = function(name, user_data) return user_data end,
        after_load = function(name, user_data) end,
    },
    plugins = {
        close_windows = {
            hooks = {'before_save', 'before_load'},
            preserve_layout = false,  -- or fun(win): boolean
            match = {
                floating = true,
                buftype = {
                    'terminal',
                },
                filetype = {
                    'neo-tree',
                    'neo-tree-popup',
                    'NeogitCommitMessage',
                    'NeogitStatus',
                    'DiffviewFilePanel',
                    'DiffviewFileHistoryPanel',
                },
                custom = false,  -- or fun(win): boolean
            },
        },
        delete_hidden_buffers = {
            hooks = {
                'before_load',
                vim.o.sessionoptions:match('buffer') and 'before_save',
            },
            force = false,  -- or fun(buf): boolean
        },
        nvim_tree = true,
        tabby = true,
        delete_buffers = false,
    },
}

local session_excluded = function()
    -- exclude by filetype
    local ft = { gitcommit = true }
    if ft[vim.bo.filetype] then return true end
    -- exclude vimdiff
    if vim.fn.bufnr("$") > 2 then return true end
end

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    nested = true,
    callback = function()
        -- ignore: file gitcommit vimdiff ...
        -- local notify = function(x) require('notify').notify(vim.inspect(x)) end
        if vim.api.nvim_buf_get_name(0) ~= '' then
            return
        end
        -- if session_excluded() then return end

        local cwd = vim.fn.getcwd()
        local root_dir = vcs_root(cwd, true) or cwd

        vim.g.session_root_dir = root_dir
        if root_dir then
            local session = require('possession.session')
            local config = require('possession.config')
            local name = vim.fn.substitute(root_dir, '/', '::', 'g')
            vim.g.session_id = name
            local path = config.session_dir.."/"..name..".json"
            if vim.fn.empty(vim.fn.glob(path)) == 0 then
                session.load(name)
            else
                session.save(name)
            end
        else
            tbm.n()
        end
    end
})

require('telescope').load_extension('possession')
vim.keymap.set('n', '<leader>s', require('telescope').extensions.possession.list, { desc = 'session: list' })

vim.api.nvim_create_user_command('Ssv', function ()
    local session = require('possession.session')
    session.save(vim.g.session_id)
end, { nargs = '?' , desc = 'save current session'})
