#!/bin/bash
install_dep(){
    apt-get update
    apt-get install -y git gcc g++ zsh aria2 make net-tools tmux
}

install_docker(){
    apt update
    apt upgrade -y
    apt install -y ca-certificates curl gnupg lsb-release
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

# 检查并安装Node.js和npm
install_nodejs_npm() {
    if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
        echo "Node.js或npm未安装，正在安装..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install node # 安装最新版本的Node.js和npm
        nvm use node
        echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.zshrc
        echo "Node.js和npm安装完毕。"
    else
        echo "Node.js和npm已安装。"
    fi
}

install_go(){
    wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
    sed -i '1 a export PATH=$PATH:/usr/local/go/bin' $HOME/.zshrc
}

install_nodejs_npm
install_go
install_node

install_node(){
    source $HOME/.zshrc
    npm install yarn pm2 ts-node -g
}

snap_shot_base() {
    mkdir -p $HOME/base-chain-node/data
    filename=$(curl -s https://mainnet-full-snapshots.base.org/latest)
    wget "https://mainnet-full-snapshots.base.org/$filename" && tar -xzvf "$filename" -C $HOME/base-chain-node/data
}