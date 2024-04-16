#!/bin/bash
install_dep(){
    apt-get update
    apt-get install -y git gcc g++ zsh aria2 make net-tools tmux jq pigz
}


change_zsh(){
    chsh -s /usr/bin/zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
}
install_dep
change_zsh
