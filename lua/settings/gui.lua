vim.o.guifont = "JetBrains Mono ExtraLight:h12"
--[[
#/usr/share/applications/neovide.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=env SHELL=/usr/local/bin/nu /usr/local/bin/neovide --multigrid --maximized
Name=Neovide
Icon=nvim
Categories=Utility;TextEditor;
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
--]]

vim.g.neovide_scale_factor = 0.9
vim.g.neovide_font_subpixel_antialiasing = 1
vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_transparency = 1
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_automatic_scaling = true

vim.g.neovide_cursor_vfx_mode = "railgun" --"sonicboom" --"wireframe"
vim.g.neovide_cursor_vfx_particle_lifetime = 2
vim.g.neovide_cursor_vfx_particle_density = 12.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_cursor_vfx_particle_phase = 10.0
