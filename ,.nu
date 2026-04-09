# 插件管理命令
export def 'plugins install' [] {
    nu scripts/plugins.nu install
}

export def 'plugins update' [name: string] {
    nu scripts/plugins.nu update $name
}

export def 'plugins sync' [] {
    nu scripts/plugins.nu sync
}

export def 'plugins list' [] {
    nu scripts/plugins.nu list
}

export def 'plugins clean' [] {
    nu scripts/plugins.nu clean
}

export def 'plugins init' [] {
    nu scripts/plugins.nu init
}

export def 'plugins status' [] {
    nu scripts/plugins.nu status
}

export def 'sync taberm' [] {
    rsync -avp plugins/nvim-taberm/ ~/world/nvim-taberm/ --exclude=.git
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

# 快捷命令
export def 'pi' [] {
    plugins install
}

export def 'ps' [] {
    plugins status
}

export def 'pl' [] {
    plugins list
}

export def "clean session" [] {
    rm -rf .local/share/nvim/session/*
}
