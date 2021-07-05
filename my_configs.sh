#!/bin/bash
# a simple script that takes care of:
# creating basic folders, important symlinks and configurations

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

cd ~

# TODOs for v1.0
# delete git history and create a new one for v1.0
# /etc/pacman.conf save it to your dotfiles
# move to lunarvim
# add code to push ssh key to git - go to one_day file
# where to put user-dirs.dirs

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

# cloning dotfiles and creating symlinks
cd ~
echo " "
echo "...starting cloning dotfiles and creating symlinks"
git clone https://github.com/jokyv/dotfiles.git ~/dot
# for the HOME folder
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

echo "...lets source all the config files"
source ~/dot/bash/.bashrc

# symlink your favourtie fonts
cd ~
echo " "
echo "...Symlink my favourite fonts to ~/.local/share/"
ln -s ~/dot/fonts/ ~/.local/share/

# nvim configurations
cd ~
echo " "
echo "...installing lubarvim"
sudo pacman -S python-pip npm xsel
pip install pynvim
sudo npm i -g neovim

# personal projects
cd ~
echo " "
echo "...adding all personal-private repos"
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

## OPTIONAL

# TMUX
ln -s ~/dot/tmux/ ~/.config/

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
