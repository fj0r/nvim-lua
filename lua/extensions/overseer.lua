require'overseer'.setup {
    actions = {
        ["My custom action"] = {
            desc = "This is an optional description. It may be omitted.",
            -- Optional function that will determine when this action is available
            condition = function(task)
                if task.name == "foobar" then
                    return true
                else
                    return false
                end
            end,
            run = function(task)
                -- Your custom logic here
            end,
        },

        -- Disable built-in actions by setting them to 'false'
        watch = false,
    },
    -- You can optionally add keymaps to run your action in the task list
    -- It will always be available in the "RunAction" menu, but it may be
    -- worth mapping it directly if you use it often.
    task_list = {
        bindings = {
            ['P'] = '<CMD>OverseerQuickAction My custom action<CR>',
        }
    }
}

local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>oo', '<cmd>OverseerToggle<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>or', '<cmd>OverseerRun<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>ob', '<cmd>OverseerBuild<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>ot', '<cmd>OverseerTaskAction<cr>', opt)
vim.api.nvim_set_keymap('n', '<leader>oq', '<cmd>OverseerQuickAction<cr>', opt)

