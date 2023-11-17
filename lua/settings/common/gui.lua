vim.opt.guicursor:append { 'a:blinkon0' }

--[[
#/usr/share/applications/neovide.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=bash -c 'export NVIM_LEVEL=x SHELL=/usr/local/bin/nu; export PATH=/opt/node/bin:$HOME/.local/bin:$PATH; /usr/local/bin/neovide --multigrid --maximized'
Name=Neovide
Icon=nvim
Categories=Utility;TextEditor;
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
--]]

local fonts = {
    mn = "Monaspace Neon:h{}",
    ma = "Monaspace Argon:h{}",
    mx = "Monaspace Xenon:h{}",
    mr = "Monaspace Radon:h{}",
    mk = "Monaspace Krypton:h{}",
    hs = "Hasklig:h{}",
    jm = "JetBrains Mono ExtraLight:h{}",
}

local function select_font(f)
    local opt = string.gmatch(f, '(%a+)(%d+)(%a*)')
    local n, s, o = opt()
    return string.gsub(fonts[n], '{}', s) .. o
end

vim.api.nvim_create_user_command('SelectFont',
    function(ctx)
        vim.opt.guifont = select_font(ctx.args)
    end,
    {
        nargs = '?',
        complete = function ()
            local ks = {}
            for k, _ in pairs(fonts) do
                table.insert(ks, k)
            end
            return ks
        end
    }
)

--> test ligature
local default_font = 'ma16'
if vim.g.neovide or vim.g.server_mode then
    vim.opt.guifont = os.getenv("NVIM_GUIFONT") or select_font(os.getenv("NVIM_FONT") or default_font)
    require('setup').global_table {
        neovide_fullscreen = false,
        neovide_remember_window_size = true,
        neovide_transparency = 1,
        neovide_floating_blur_amount_x = 2.0,
        neovide_floating_blur_amount_y = 2.0,
        neovide_hide_mouse_when_typing = true,
        neovide_underline_automatic_scaling = true,
        neovide_cursor_vfx_mode = "railgun", -- "sonicboom" -- "wireframe" -- "railgun"
        neovide_cursor_vfx_particle_lifetime = 2,
        neovide_cursor_vfx_particle_density = 12.0,
        neovide_cursor_vfx_particle_speed = 10.0,
        neovide_cursor_vfx_particle_phase = 10.0,
    }

    vim.g.neovide_scale_factor = os.getenv("NEOVIDE_SCALE_FACTOR") or 0.7
    -- https://github.com/neovide/neovide/issues/1331
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
        pattern = "*",
        callback = function()
            if vim.g.loaded_clipboard_provider then
                vim.g.loaded_clipboard_provider = nil
                vim.api.nvim_cmd({ cmd = 'runtime', args = { 'autoload/provider/clipboard.vim' } }, {})
            end
        end
    })

    require('setup').keymap_table {
        { "<C-=>", ":lua vim.opt.linespace = math.min(vim.opt.linespace:get() + 1,  10)<CR>", 's' },
        { "<C-->", ":lua vim.opt.linespace = math.max(vim.opt.linespace:get() - 1,  0)<CR>", 's' },
        { "<C-+>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  1.0)<CR>", 's' },
        { "<C-_>", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.5)<CR>", 's' },
        { "<C-M-=>", ":lua vim.g.neovide_transparency = math.min(vim.g.neovide_transparency + 0.05, 1.0)<CR>", 's' },
        { "<C-M-->", ":lua vim.g.neovide_transparency = math.max(vim.g.neovide_transparency - 0.05, 0.0)<CR>", 's' },
    }
end

if vim.g.neovide then
    local function set_ime(args)
        if args.event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end

    local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = set_ime
    })

    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
        group = ime_input,
        pattern = "[/\\?]",
        callback = set_ime
    })
end
