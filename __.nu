export def 'sync taberm' [] {
    rsync -avp lazy/packages/nvim-taberm/ ~/world/nvim-taberm/ --exclude=.git
}

export def 'reset packer' [] {
    rm -f plugin/packer_compiled.lua
    rm -rf pack/packer/start/*
    rm -rf pack/packer/opt/*
    git clone --depth 1 https://github.com/wbthomason/packer.nvim pack/packer/start/packer.nvim
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

export def "reset treesitter" [] {
    let tsl = open lua/lang/treesitter_lang.json | str join ' '
    pp ...[nvim --headless -c $"TSUpdateSync ($tsl)" -c "quit"]
}

def cmpl-nvim-tar [] {
    ls ~/Downloads/nvim-linux64*.tar.gz | get name
}

export def "install" [file:string@cmpl-nvim-tar] {
    sudo tar zxvf $file -C /usr/local/ --strip-components=1
}

export def "clean session" [] {
    rm -rf .local/share/nvim/session/*
}
