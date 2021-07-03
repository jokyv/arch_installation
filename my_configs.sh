#!/bin/bash
# a simple script that takes care of:
# creating basic folders, important symlinks and configurations

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

cd ~

# please note:
# bash history file moved
# git config file moved
# dot file should be updated as well

# shouldnt i symblink the gitconfig file that i saved? 
# configure git
echo " "
echo "...starting configuring git"
git config --global user.name "John Kyvetos"
git config --global user.email johnkyvetos@gmail.com
# store password for 8 hours only
git config --global credential.helper 'cache --timeout=28800'

cd ~
echo " "
echo "..starting cloning dotfiles and creating symlinks"
git clone https://github.com/jokyv/dotfiles.git ~/dot
# for the HOME folder
ln -s ~/dot/bash/.bashrc ~/.bashrc
ln -s ~/dot/bash/.bash_profile ~/.bash_profile
ln -s ~/dot/.xinitrc ~/.xinitrc # this has moved as well
# for the .config/ folder
ln -s ~/dot/tmux/ ~/.config/
ln -s ~/dot/alacritty ~/.config/
ln -s ~/dot/bspwm ~/.config/
ln -s ~/dot/polybar ~/.config/
ln -s ~/dot/sxhkd ~/.config/
echo "Lets source all the config files"
source ~/dot/bash/.bashrc

# fonts
cd ~
echo " "
echo "...Symlink my favourite fonts to ~/.local/share/"
ln -s ~/dot/fonts/ ~/.local/share/

# nvim configurations
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

cd ~
echo " "
echo "...adding all personal repos"
mkdir repos
git clone https://github.com/jokyv/my_wiki.git ~/repos/

# wallpapers and pics
cd ~
echo " "
echo "...creating pics folder and adding my wallpapers"
mkdir pics
git clone https://github.com/jokyv/wallpapers ~/pics/
echo " "
echo "add work repos manuall!"
echo "press [ENTER] key to continue..."
read y


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
echo "all configurations are now done!"
