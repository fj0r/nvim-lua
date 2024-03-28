local M = {}
--[[
#/usr/share/applications/neovide.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=bash -c 'export NVIM_LEVEL=x SHELL=/usr/local/bin/nu; export PATH=/opt/node/bin:$HOME/.local/bin:$PATH; /usr/local/bin/neovide --maximized'
Name=Neovide
Icon=nvim
Categories=Utility;TextEditor;
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
--]]


local features = { 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt', 'dlig' }

local fonts_abbr = {
    nar = "MonaspiceAr NFM",
    nxe = "MonaspiceXe NFM",
    nne = "MonaspiceNe NFM",
    nkr = "MonaspiceKr NFM",
    nrn = "MonaspiceRn NFM",
    mne = "Monaspace Neon",
    mar = "Monaspace Argon",
    mxe = "Monaspace Xenon",
    mrn = "Monaspace Radon",
    mkr = "Monaspace Krypton",
    hs = "Hasklig",
    jm = "JetBrains Mono ExtraLight",
}


function M.parse(f)
    local opt = string.gmatch(f, '(%a+)(%d*)(%a*)')
    local n, s, o = opt()
    if s ~= '' then
        vim.g.select_font_size = s
    end
    M.name = fonts_abbr[n]
    M.size = vim.g.select_font_size
    M.opt = o
    M.features = features
    return M
end

function M:guifont()
    return self.name .. ":h" .. self.size .. self.opt
end

function M.from_env()
    local default_font = 'nar16'
    return M.parse(os.getenv("NVIM_FONT") or default_font)
end


vim.g.select_font_size = 12
vim.api.nvim_create_user_command('SelectFont',
    function(ctx)
        vim.opt.guifont = M.parse(ctx.args):guifont()
    end,
    {
        nargs = '?',
        complete = function()
            local ks = {}
            for k, _ in pairs(fonts_abbr) do
                table.insert(ks, k)
            end
            return ks
        end
    }
)

return M
