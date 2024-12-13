#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install -y build-essential pkg-config libssl-dev git-all
sudo apt install -y protobuf-compiler
sudo apt install -y cargo

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source "$HOME/.cargo/env"
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

rustup update

sudo apt install -y screen nano

echo "Установка завершена!"
