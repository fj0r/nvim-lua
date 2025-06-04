local opts = function(desc)
    return { noremap = true, silent = true, desc = desc }
end
vim.keymap.set('n', '[e', vim.diagnostic.open_float, opts 'diagnostic open_float')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts 'diagnostic goto_prev')
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts 'diagnostic goto_next')
vim.keymap.set('n', '[q', vim.diagnostic.setloclist, opts 'diagnostic setloclist')

local on_attach = function(client, bufnr, plugin, ctx)
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

    local km = {
        declaration = vim.lsp.buf.declaration,
        references = vim.lsp.buf.references,
        definition = vim.lsp.buf.definition,
        hover = vim.lsp.buf.hover,
        implementation = vim.lsp.buf.implementation,
        signature_help = vim.lsp.buf.signature_help,
        add_workspace_folder = vim.lsp.buf.add_workspace_folder,
        remove_workspace_folder = vim.lsp.buf.remove_workspace_folder,
        list_workspace_folders = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        type_definition = vim.lsp.buf.type_definition,
        rename = vim.lsp.buf.rename,
        code_action = vim.lsp.buf.code_action,
    }

    ctx.apply_keymap(plugin, km)

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


return {
    setup = function(plugin, ctx)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my.lsp', {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                local bufnr = args.buf
                on_attach(client, bufnr, plugin, ctx)
            end,
        })
    end
}
