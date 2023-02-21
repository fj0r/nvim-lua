local h = require('lazy_helper')

return {
    {
        'stevearc/overseer.nvim',
        lazy = true,
        keys = {
            { '<leader>t', '<cmd>OverseerRun<cr>' },
            { '<C-t>', '<cmd>OverseerToggle<cr>' },
            { '<C-t>', '<cmd>OverseerToggle<cr>', mode = 't' },
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
        config = h.plugins 'overseer',
    },
}
