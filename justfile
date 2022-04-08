reset-packer:
    rm plugin/packer_compiled.lua
    rm -rf pack/packer/start/*
    rm -rf pack/packer/opt/*
    git clone --depth 1 https://github.com/wbthomason/packer.nvim pack/packer/start/packer.nvim
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

tsl:
    #!/bin/bash
    export tsl=$(cat lua/lang/treesitter_lang.json| jq -r 'join(" ")')
    export tsl_cmd=$(echo nvim --headless -c "TSUpdateSync ${tsl}" -c "quit")
    echo $tsl_cmd
    eval $tsl_cmd
