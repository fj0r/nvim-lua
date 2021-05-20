require 'navigator'.setup {
  debug = false, -- log output not implemented
  code_action_icon = " ",
  width = nil, -- valeu of cols TODO allow float e.g. 0.6
  height = nil,
  on_attach = nil,
  -- function(client, bufnr)
  --   -- your on_attach will be called at end of navigator on_attach
  -- end,
  code_action_prompt = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
  lsp = {
    format_on_save = true, -- set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
    tsserver = {
      filetypes = {'typescript'} -- disable javascript etc,
      -- set to {} to disable the lspclient for all filetype
    }
  }
}
