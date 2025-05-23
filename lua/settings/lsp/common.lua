local opts = function(desc)
    return { noremap = true, silent = true, desc = desc }
end
vim.keymap.set('n', '[e', vim.diagnostic.open_float, opts 'diagnostic open_float')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts 'diagnostic goto_prev')
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts 'diagnostic goto_next')
vim.keymap.set('n', '[q', vim.diagnostic.setloclist, opts 'diagnostic setloclist')

local on_attach = function(client, bufnr)
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

    -- Mappings.
    local bufopts = function(desc)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts 'lsp declaration')
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts 'lsp definition')
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts 'lsp hover')
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts 'lsp implementation')
    vim.keymap.set('n', '[k', vim.lsp.buf.signature_help, bufopts 'lsp signature_help')
    vim.keymap.set('n', '[wa', vim.lsp.buf.add_workspace_folder, bufopts 'lsp add_workspace_folder')
    vim.keymap.set('n', '[wr', vim.lsp.buf.remove_workspace_folder, bufopts 'lsp remove_workspace_folder')
    vim.keymap.set('n', '[wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        bufopts 'lsp list_workspace_folders')
    vim.keymap.set('n', '[D', vim.lsp.buf.type_definition, bufopts 'lsp type_definition')
    vim.keymap.set('n', '[r', vim.lsp.buf.rename, bufopts 'lsp rename')
    vim.keymap.set('n', '[a', vim.lsp.buf.code_action, bufopts 'lsp code_action')
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts 'lsp references')

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "[f", function() vim.lsp.buf.format { async = true } end, bufopts 'lsp format')
    end
    -- if client.server_capabilities.documentRangeFormattingProvider then
    --     vim.keymap.set("v", "[f", vim.lsp.buf.range_formatting, bufopts 'lsp range_format')
    -- end

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

vim.lsp.config('*', {
    -- root_markers = { '.git', '.hg' },
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf
        on_attach(client, bufnr)
    end,
})
