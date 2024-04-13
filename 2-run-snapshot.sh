
snap_shot_base() {
    mkdir -p $HOME/base-chain-node/data
    cd $HOME/base-chain-node/
    filename=$(curl -s https://mainnet-full-snapshots.base.org/latest)
    aria2c -o "$filename" -x 4 -s 12 "https://mainnet-full-snapshots.base.org/$filename" && tar -xzvf "$filename" -C $HOME/base-chain-node/data
    cd $HOME/base-chain-node/base-node
    docker compose up --build
}

snap_shot_base