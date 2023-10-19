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

if vim.g.neovide or vim.g.server_mode then
    vim.opt.guifont = os.getenv("NVIM_GUIFONT") or "JetBrains Mono ExtraLight:h12:#e-subpixelantialias"
    require('setup').global_table {
        neovide_scale_factor = 1,
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

