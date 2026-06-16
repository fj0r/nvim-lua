if not vim.g.has_git then
    return
end
local langs = {
    "css",
    "diff",
    "dockerfile",
    "go",
    "gomod",
    "haskell",
    "html",
    "javascript",
    "jsdoc",
    "json",
    -- lua, markdown, markdown_inline: Neovim 0.12+ 内置
    "nu",
    "python",
    "regex",
    "rust",
    "sql",
    "toml",
    "typescript",
    "vue",
    "yaml",
}

vim.g.treesitter_lang = langs

-- ── 编译器检测 ──────────────────────────────────────
if os.getenv('NVIM_MUSL') == '1' then
    require 'nvim-treesitter.install'.compilers = { "musl-gcc" }
    require 'nvim-treesitter.parsers'.command_extra_args = { ["musl-gcc"] = { "-I/usr/include", "-static" } }
end

local compilers = { "cc", "gcc", "clang", "cl", "zig" }
local has_cc = false
for _, cc in ipairs(compilers) do
    if vim.fn.executable(cc) == 1 then
        has_cc = true
        break
    end
end

-- ── nvim-treesitter setup（新版 API）──────────────────
require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
}

-- 安装 parsers（有编译器时，异步执行避免阻塞启动）
if has_cc then
    vim.schedule(function()
        require('nvim-treesitter.install').ensure_installed(langs)
    end)
end

-- ── FileType autocmd：启用 highlight / fold / indent ──
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function(args)
        local ok, lang = pcall(vim.treesitter.language.get_lang, args.match)
        if not ok or not lang then return end

        -- Check if parser exists
        local parser_ok, _ = pcall(vim.treesitter.language.inspect, lang)
        if not parser_ok then return end

        -- Try to start treesitter, ignore errors
        pcall(vim.treesitter.start, args.buf, lang)

        -- Enable fold
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'

        -- Enable indent
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- ── textobjects ──────────────────────────────────────
require('nvim-treesitter-textobjects').setup {
    select = {
        lookahead = true,
    },
    move = {
        set_jumps = true,
    },
}

local select = require 'nvim-treesitter-textobjects.select'
local move = require 'nvim-treesitter-textobjects.move'
local swap = require 'nvim-treesitter-textobjects.swap'

-- select keymaps
vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ak', function() select.select_textobject('@comment.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ab', function() select.select_textobject('@block.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ib', function() select.select_textobject('@block.inner', 'textobjects') end)

-- move keymaps
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

-- swap keymaps
vim.keymap.set('n', '[S', function() swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', ']S', function() swap.swap_previous('@parameter.inner') end)
