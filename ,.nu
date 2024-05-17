### {{{ base.nu
$env.comma_scope = {|_|{ created: '2024-05-01{3}12:25:14' }}
$env.comma = {|_|{}}
### }}}

'sync taberm'
| comma fun {
    rsync -avp lazy/packages/nvim-taberm/ ~/world/nvim-taberm/ --exclude=.git
}

'reset packer'
| comma fun {
    rm -f plugin/packer_compiled.lua
    rm -rf pack/packer/start/*
    rm -rf pack/packer/opt/*
    git clone --depth 1 https://github.com/wbthomason/packer.nvim pack/packer/start/packer.nvim
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

"reset treesitter"
| comma fun {
    let tsl = open lua/lang/treesitter_lang.json | str join ' '
    pp ...[nvim --headless -c $"TSUpdateSync ($tsl)" -c "quit"]
}

"install"
| comma fun {|a,s,_|
    sudo tar zxvf $a.0 -C /usr/local/ --strip-components=1
} {
    cmp: {
        ls ~/Downloads/nvim-linux64*.tar.gz | get name
    }
}
