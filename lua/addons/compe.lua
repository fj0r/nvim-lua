vim.o.completeopt = "menuone,noselect"
local has_plugin = require'packer_helper'.has_plugin

require'compe'.setup {
    enabled          = true;
    autocomplete     = true;
    debug            = false;
    min_length       = 1;
    preselect        = 'enable';
    throttle_time    = 80;
    source_timeout   = 200;
    incomplete_delay = 400;
    max_abbr_width   = 100;
    max_kind_width   = 100;
    max_menu_width   = 100;
    documentation    = true;

    source = {
        nvim_lsp              = {priority = 9999, sort = true},
        path                  = true,
        buffer                = true,
        calc                  = true,
        vsnip                 = true,
        nvim_lua              = false,
        tags                  = false,
        vim_dadbod_completion = true,
        -- snippets_nvim = {kind = "  "},
        -- ultisnips = {kind = "  "},
        -- treesitter = {kind = "  "},
        spell                 = {priority = 1},
        org                   = has_plugin'orgmode.nvim',
        emoji                 = {filetypes={"markdown", "text"}}
    };
}


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end


vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require'packer_helper'.config_with_plugin {
    ['nvim-autopairs'] = function ()
        vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm(luaeval(\"require 'nvim-autopairs'.autopairs_cr()\"))", {expr = true})
    end,
    ['_'] = function ()
        vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true})
    end
}


vim.api.nvim_set_keymap("i", "<S-Space>", "compe#complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-c>", "compe#close('<C-c>')", {expr = true})
vim.api.nvim_set_keymap("i", "<C-j>", "compe#scroll({ 'delta': +4 })", {expr = true})
vim.api.nvim_set_keymap("i", "<C-k>", "compe#scroll({ 'delta': -4 })", {expr = true})
