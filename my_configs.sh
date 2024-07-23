#!/bin/bash

# a simple script that takes care of:
# creating basic folders, important symlinks and configurations

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fail

# make repos folder and cd into it
cd ~
mkdir repos
cd repos

# install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# install Paru apps
cd ~
echo " "
echo "...installing brave, dprint, trashy"
paru brave-bin dprint trashy

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
# for the .config/ folder
ln -s ~/dot/alacritty ~/.config/
ln -s ~/dot/fd ~/.config/
ln -s ~/dot/git ~/.config/
ln -s ~/dot/starship.toml ~/.config/

## Niri wm settings
# Make a link to wallpaper:
mkdir pics
cd pics
git clone git@github.com:jokyv/wallpapers.git ~/pics/wallpapaers/
ln -sf ~/pics/wallpapers/purple_view.png ~/.config/niri/wallpaper

# Needed services for Niri wm:
mkdir -p                                               ~/.config/systemd/user/niri.service.wants
ln -s /usr/lib/systemd/user/waybar.service             ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/cliphist.service          ~/.config/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/mako.service               ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/swaybg.service            ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/darkman.service           ~/.config/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/gnome-polkit-agent.service ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/playctld.service          ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/wlsunset.service          ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/ydotool.service           ~/.config/systemd/user/niri.service.wants/

echo "...lets source all the config files"
# source ~/.profile

# symlink your favourtie fonts
cd ~
echo " "
echo "...symlink my favourite fonts to ~/.local/share/"
ln -s ~/dot/fonts/ ~/.local/share/

# personal projects
cd ~
echo " "
echo "...adding all personal-private repos"
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

# # TMUX
# echo " "
# echo ":: Tmux"
# ln -s ~/dot/tmux/ ~/.config/

echo " "
echo "...all configurations are now done!"
