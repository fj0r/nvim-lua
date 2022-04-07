local on_attach = function (client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function buf_set_keymap(mode, k, v)
        vim.api.nvim_buf_set_keymap(bufnr, mode, k, v, { noremap = true, silent = true })
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    buf_set_keymap('n', '[q', '<cmd>lua vim.diagnostic.set_loclist()<CR>')

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_set_keymap('n', '[k', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_set_keymap('n', '[wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    buf_set_keymap('n', '[wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    buf_set_keymap('n', '[wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    buf_set_keymap('n', '[D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    buf_set_keymap('n', '[r', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap('n', '[a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "[f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "[f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
--[[
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}
--]]
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require'lspconfig'
lspconfig.util.default_config = vim.tbl_extend("force",
lspconfig.util.default_config,
{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    }
})

