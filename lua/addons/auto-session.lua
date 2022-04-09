vim.g.auto_session_root_dir = vim.g.data_root.."/sessions/"
local opts = {
    log_level = 'error',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.g.auto_session_root_dir,
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil,
    pre_save_cmds = {"NvimTreeClose"},
    post_restore_cmds = {"NvimTreeRefresh"}
}

require('auto-session').setup(opts)

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

local has_plugin = require'packer_helper'.has_plugin
if has_plugin'session-lens' and has_plugin'telescope' then
    require'telescope'.load_extension("session-lens")
    vim.api.nvim_set_keymap('n', '<leader>o', "<cmd>lua require('session-lens').search_session()<cr>", { noremap = true })
end
