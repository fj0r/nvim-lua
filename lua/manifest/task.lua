local h = require('lazy_helper')
local m = require('setup').mod

return {
    {
        'stevearc/overseer.nvim',
        lazy = true,
        keys = {
            { m 't',        '<cmd>OverseerToggle<cr>' },
            { m 't',        '<cmd>OverseerToggle<cr>',     mode = 't' },
            { '<leader>or', '<cmd>OverseerRun<cr>' },
            { '<leader>oo', '<cmd>OverseerToggle<cr>' },
            { '<leader>ob', '<cmd>OverseerBuild<cr>' },
            { '<leader>ot', '<cmd>OverseerTaskAction<cr>' },
            { '<leader>oq', '<cmd>OverseerQuickAction<cr>' },
        },
        cmd = {
            'OverseerRun',
            'OverseerOpen',
            'OverseerBuild',
            'OverseerToggle',
            'OverseerRunCmd',
            'OverseerQuickAction',
            'OverseerTaskAction'
        },
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = h.settings 'overseer',
        enabled = vim.g.nvim_level >= 2,
    },
}
