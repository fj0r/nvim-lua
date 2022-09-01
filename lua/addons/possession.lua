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
            preserve_layout = true,  -- or fun(win): boolean
            match = {
                floating = true,
                buftype = {},
                filetype = {},
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

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        -- TODO:
    end
})

require('telescope').load_extension('possession')
vim.keymap.set('n', '<leader>s', require('telescope').extensions.possession.list, { desc = 'session: list' })
