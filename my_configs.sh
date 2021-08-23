#!/bin/bash

# a simple script that takes care of:
# creating basic folders, important symlinks and configurations

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fail

cd ~
# folder for all git repos
mkdir repos

# install paru, polybar and i3lock
cd ~
echo " "
echo "...installing paru"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
paru polybar i3lock

# ssh key to github so i can download dotfiles
echo " " 
ssh-keygen -t  ecdsa -b 521
echo " "
echo "Add this public key, to you're GitHub account before continuing"
echo " "
cat ~/.ssh/id_ecdsa.pub
echo " "
echo "Press [ENTER] when you are ready to continue"
read y

# cloning dotfiles and creating symlinks
cd ~
echo " "
echo "...starting cloning dotfiles and creating symlinks"
# for the HOME folder
git clone git@github.com:jokyv/dotfiles ~/dot
ln -s ~/dot/bash/.bashrc ~/
ln -s ~/dot/bash/.bash_profile ~/
ln -s ~/dot/.profile ~/
# for the .config/ folder
ln -s ~/dot/X11 ~/.config/
ln -s ~/dot/alacritty ~/.config/
ln -s ~/dot/bspwm ~/.config/
ln -s ~/dot/polybar ~/.config/
ln -s ~/dot/sxhkd ~/.config/
ln -s ~/dot/fd ~/.config/
ln -s ~/dot/git ~/.config/
ln -s ~/dot/starship.toml ~/.config/
ln -s ~/dot/lvim ~/.config/

echo "...lets source all the config files"
source ~/.profile

# symlink your favourtie fonts
cd ~
echo " "
echo "...symlink my favourite fonts to ~/.local/share/"
ln -s ~/dot/fonts/ ~/.local/share/

# lunarvim installation and configuration
cd ~
echo " "
echo "...installing lunarvim"
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh)

# personal projects
cd ~
echo " "
echo "...adding all personal-private repos"
git clone git@github.com:jokyv/my_wiki.git ~/repos/
git clone git@github.com:jokyv/notes.git ~/repos/

# wallpapers and pics
cd ~
echo " "
echo ":: Wallpapers and pics"
echo "...creating pics folder and adding my wallpapers repo"
mkdir pics
git clone git@github.com:jokyv/wallpapers.git ~/pics/
echo " "
echo "add work repos manually if you want"
echo "press [ENTER] key to continue..."
read y

## OPTIONAL INSTALLATIONS

# TMUX
echo " "
echo ":: Tmux"
ln -s ~/dot/tmux/ ~/.config/

# # Miniconda
# echo " "
# echo ":: Miniconda "
# echo "...downloading miniconda and installing it"
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
# sh ~/miniconda.sh -b -f -p $HOME/mconda
# rm ~/miniconda.sh
# echo "...cloning my packages into mconda lib"
# echo "pres [ENTER] key to continue"
# read y
# git clone git@github.com:jokyv/jokyv.git ~/mconda/lib/python3.9/site-packages/
# git clone git@github.com:jokyv/jokyv_ml.git ~/mconda/lib/python3.9/site-packages/
# echo "...ipython configurations"
# cd ~/.ipython/profile_default
# ipython profile create
# cd profile_default
# nvim ipython_config.py
# echo "uncomment autoindent and make it false"

echo " "
echo "...all configurations are now done!"
