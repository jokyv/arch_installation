#!/bin/bash
# a simple script that takes care of:
# creating basic folders, important symlinks and configurations

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

cd ~

# TODOs for v1.0
# bash history file moved
# git config file moved
# dot file should be updated as well
# global fd ignore file is in .config/fd
# global git ignore file
# /etc/pacman.conf save it to your dotfiles
# shouldnt i symblink the gitconfig file that i saved? 

# configure git
cd ~
echo " "
echo "...starting configurations"
echo "...configuring git"
git config --global user.name "John Kyvetos"
git config --global user.email johnkyvetos@gmail.com
# store password for 8 hours only
git config --global credential.helper 'cache --timeout=28800'

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

# all the .config files
cd ~
echo " "
echo "...starting cloning dotfiles and creating symlinks"
git clone https://github.com/jokyv/dotfiles.git ~/dot
# for the HOME folder
ln -s ~/dot/bash/.bashrc ~/.bashrc
ln -s ~/dot/bash/.bash_profile ~/.bash_profile
ln -s ~/dot/.xinitrc ~/.xinitrc # TODO this has moved as well
# for the .config/ folder
ln -s ~/dot/tmux/ ~/.config/
ln -s ~/dot/alacritty ~/.config/
ln -s ~/dot/bspwm ~/.config/
ln -s ~/dot/polybar ~/.config/
ln -s ~/dot/sxhkd ~/.config/
echo "...lets source all the config files"
source ~/dot/bash/.bashrc

# symlink your favourtie fonts
cd ~
echo " "
echo "...Symlink my favourite fonts to ~/.local/share/"
ln -s ~/dot/fonts/ ~/.local/share/

# nvim configurations
# TODO change to lunarvim
cd ~
echo " "
echo "...adding configurations and plugins for neovim "
git clone https://github.com/jokyv/nvim.git ~/.config/
sudo pacman -S python-pip npm xsel
pip install pynvim
sudo npm i -g neovim
echo "CoC configuration and modules installation"
echo "requies neovim and node installed"
# Install neovim extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi

# Change extension names to the extensions you need
npm install coc-json coc-python coc-snippets coc-vimlsp coc-pairs coc-jedi coc-explorer coc-sh --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# personal projects
cd ~
echo " "
echo "...adding all personal/private repos"
mkdir repos
git clone https://github.com/jokyv/my_wiki.git ~/repos/
git clone https://github.com/jokyv/notes.git ~/repos/

# wallpapers and pics
cd ~
echo " "
echo ":: Wallpapers and pics"
echo "...creating pics folder and adding my wallpapers"
mkdir pics
git clone https://github.com/jokyv/wallpapers ~/pics/
echo " "
echo "add work repos manually if you want"
echo "press [ENTER] key to continue..."
read y

# Miniconda
echo " "
echo ":: Miniconda "
echo "...downloading miniconda and installing it"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
sh ~/miniconda.sh -b -f -p $HOME/mconda
rm ~/miniconda.sh
# TODO do i need this? already including the mconda path with my bashrc script
conda init bash
echo "...cloning my packages into mconda lib"
echo "pres [ENTER] key to continue"
read y
git clone https://github.com/jokyv/jokyv.git ~/mconda/lib/python3.9/site-packages/
echo "...ipython configurations"
cd ~/.ipython/profile_default
ipython profile create
cd profile_default
nvim ipython_config.py
# FIXME how to do this with nvim?
echo "uncomment autoindent and make it false"

echo " "
echo "...all configurations are now done!"
