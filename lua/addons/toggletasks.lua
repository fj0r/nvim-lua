require('toggletasks').setup {
    debug = false,
    silent = false,  -- don't show "info" messages
    short_paths = true,  -- display relative paths when possible
    -- Paths (without extension) to task configuration files (relative to scanned directory)
    -- All supported extensions will be tested, e.g. '.toggletasks.json', '.toggletasks.yaml'
    search_paths = {
        'toggletasks',
        '.toggletasks',
        '.nvim/toggletasks',
    },
    -- Directories to consider when searching for available tasks for current window
    scan = {
        global_cwd = true,  -- vim.fn.getcwd(-1, -1)
        tab_cwd = true,     -- vim.fn.getcwd(-1, tab)
        win_cwd = true,     -- vim.fn.getcwd(win)
        lsp_root = true,    -- root_dir for first LSP available for the buffer
        dirs = {},          -- explicit list of directories to search
    },
    -- Language server priorities when selecting lsp_root (default is 0)
    lsp_priorities = {
        ['null-ls'] = -10,
    },
    -- Default values for task configuration options (available options described later)
    defaults = {
        close_on_exit = false,
        hidden = true,
    },
    -- Configuration of telescope pickers
    telescope = {
        spawn = {
            open_single = true,  -- auto-open terminal window when spawning a single task
            show_running = true, -- include already running tasks in picker candidates
            -- Replaces default select_* actions to spawn task (and change toggleterm
            -- direction for select horiz/vert/tab)
            mappings = {
                select_float = '<C-f>',
                spawn_smart = '<C-a>',  -- all if no entries selected, else use multi-select
                spawn_all = '<M-a>',    -- all visible entries
                spawn_selected = nil,   -- entries selected via multi-select (default <tab>)
            },
        },
        -- Replaces default select_* actions to open task terminal (and change toggleterm
        -- direction for select horiz/vert/tab)
        select = {
            mappings = {
                select_float = '<C-f>',
                open_smart = '<C-a>',
                open_all = '<M-a>',
                open_selected = nil,
                kill_smart = '<C-q>',
                kill_all = '<M-q>',
                kill_selected = nil,
                respawn_smart = '<C-s>',
                respawn_all = '<M-s>',
                respawn_selected = nil,
            },
        },
    },
}

require('telescope').load_extension('toggletasks')

vim.keymap.set('n', '<leader>j', require('telescope').extensions.toggletasks.spawn, { desc = 'toggletasks: spawn' })
vim.keymap.set('n', '<leader>k', require('telescope').extensions.toggletasks.select, { desc = 'toggletasks: select' })
