install_node(){
    npm install yarn pm2 ts-node -g
}

snap_shot_base() {
    mkdir -p $HOME/base-chain-node/data
    cd $HOME/base-chain-node/
    filename=$(curl -s https://mainnet-full-snapshots.base.org/latest)
    wget "https://mainnet-full-snapshots.base.org/$filename" && tar -xzvf "$filename" -C $HOME/base-chain-node/data
    cd $HOME/base-chain-node/base-node
    docker compose up --build
}

source $HOME/.zshrc
install_node()
tmux new -s base

snap_shot_base()