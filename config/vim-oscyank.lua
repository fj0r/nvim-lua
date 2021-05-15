vim.g.oscyank_max_length = 1000000
vim.api.nvim_command("autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif")
