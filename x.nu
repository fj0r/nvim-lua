export def 'sync taberm' [] {
    rsync -avp lazy/packages/nvim-taberm/ ~/world/nvim-taberm/ --exclude=.git
}

export def init [] {
    nvim -u init.lua --headless "+Lazy! sync" +qa
}

export def "reset treesitter" [] {
    let tsl = open lua/lang/treesitter_lang.json | str join ' '
    nvim --headless -c $"TSUpdateSync ($tsl)" -c "quit"
}

export def "clean session" [] {
    rm -rf .local/share/nvim/session/*
}
