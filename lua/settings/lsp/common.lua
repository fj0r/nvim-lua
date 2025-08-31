local on_attach = function(client, bufnr, bufkeys, ctx)
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
        format = function() vim.lsp.buf.format { async = true } end,
    }
    local prefixer = function(fn, desc) return 'lsp ' .. fn end

    ctx.apply_keymap(bufkeys, km, { buf = bufnr, desc = prefixer })

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        ctx.apply_keymap(
            bufkeys,
            km,
            { buf = bufnr, desc = prefixer }
        )
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



return {
    setup = function(plugin, ctx)
        local km = {
            open_float = vim.diagnostic.open_float,
            goto_prev = vim.diagnostic.goto_prev,
            goto_next = vim.diagnostic.goto_next,
            setloclist = vim.diagnostic.setloclist,
        }
        local keys = {}
        local bufkeys = {}
        for _, k in ipairs(plugin.keys) do
            if k.remap then
                k.remap = nil
                table.insert(bufkeys, k)
            else
                table.insert(keys, k)
            end
        end

        local prefixer = function(fn, desc) return 'diagnostic ' .. fn end
        ctx.apply_keymap(keys, km, { desc = prefixer })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my.lsp', {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                local bufnr = args.buf
                on_attach(client, bufnr, bufkeys, ctx)
            end,
        })
    end
}
