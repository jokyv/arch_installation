#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

# install rust via rustup (recommended by Arch WIKI)
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# rust most frequently used packages
cargo install atuin bottom cargo-cache fd-find ripgrep hyperfine procs bat starship alacritty tokei onefetch cargo-update erdtree stylua paru tock git-delta taplo-cli topgrade trashy zellij
