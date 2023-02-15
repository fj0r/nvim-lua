local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '[q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '[k', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '[wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '[wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '[wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '[D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '[r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '[a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    -- Set some keybinds conditional on server capabilities
    if vim.version().api_level > 10 then
        if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set("n", "[f", vim.lsp.buf.format, bufopts)
        end
    else
        if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set("n", "[f", vim.lsp.buf.formatting, bufopts)
        end
        if client.server_capabilities.documentRangeFormattingProvider then
            vim.keymap.set("v", "[f", vim.lsp.buf.range_formatting, bufopts)
        end
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
        hi! link LspReferenceRead MatchParen
        hi! link LspReferenceText MatchParen
        hi! link LspReferenceWrite MatchParen
        ]]
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end


-- :TODO:
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require 'lspconfig'
lspconfig.util.default_config = vim.tbl_extend("force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150
        }
    }
)
