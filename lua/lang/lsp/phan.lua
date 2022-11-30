require'lspconfig'.phan.setup{
    cmd = {
        "php", "/opt/language-server/phan/phan.phar",
        "-m", "json", "--no-color", "--no-progress-bar",
        "-x", "-u", "-S",
        "--language-server-on-stdin",
        "--allow-polyfill-parser"
    }
}
