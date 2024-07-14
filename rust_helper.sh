#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

# install rust via rustup (recommended by Arch WIKI)
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# rust most frequently used packages
cargo install atuin cargo-cache fd-find ripgrep bat starship tokei cargo-update paru git-delta taplo-cli trashy eza typos-cli dprint git-cliff inlyne skim
