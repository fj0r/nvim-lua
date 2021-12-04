reset-packer:
    rm -rf pack/packer/start/*
    rm -rf pack/packer/opt/*
    git clone --depth 1 https://github.com/wbthomason/packer.nvim pack/packer/start/packer.nvim
