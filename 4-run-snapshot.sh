
snap_shot_base() {
    path=$HOME/base-chain-node
    mkdir -p $path/data
    cd $path
    filename=$(curl -s https://mainnet-full-snapshots.base.org/latest)
    aria2c -o "$filename" -x 4 -s 12 "https://mainnet-full-snapshots.base.org/$filename" 
    tar -xvf "$filename"  -C $path/data --use-compress-program=pigz
    cd $path/base-node
    docker compose up --build
}

snap_shot_base