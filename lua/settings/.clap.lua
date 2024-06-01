vim.g['clap_layout'] = { relative = 'editor' }
vim.g['clap_open_action'] = { ['ctrl-t'] = 'tab split', ['ctrl-s']= 'split', ['ctrl-v']= 'vsplit' }
vim.g['clap_popup_border'] = 'nil'

vim.cmd [[autocmd FileType clap_input call compe#setup({ 'enabled': v:false }, 0)]]
