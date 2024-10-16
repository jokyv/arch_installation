> [!IMPORTANT]
> This repo has been archived!!
> Follow the new version at [link](https://github.com/jokyv/dotfiles)

# Arch installation

- Download Arch ISO from the following [link](https://archlinux.org/download/).
- Verify the integrity of the ISO image.
- Write the ISO into a USB drive using the command:

```console
dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/sdx conv=fsync oflag=direct status=progress
```

- For more detailed instructions on [link](https://wiki.archlinux.org/title/USB_flash_installation_medium).
- Boot computer with the USB drive plugged in.
- Check if you have internet

```console
ping -c 3 archlinux.org
```

- if no internet follow instructions on this [link](https://wiki.archlinux.org/index.php/Iwd#iwctl).

```bash
iwctl
device list
station wlan0 connect <wifi name>
# enter password to connect
exit
```

- Enable parallel downloads by uncommenting the ParallelDOwnloads variable at:

```console
nano /etc/pacman.conf
```

### Installation - Option 1

```console
archinstall
```

- Follow on screen instructions with end outcome like the below:

![Arch installation](images/archinstallation.png)

- add basic packages such as: `git neovim amd-ucode`
- At the end just `reboot`.

#### Dependencies for Niri wm

```
niri fuzzel cliphist wl-clipboard zathura nautilus ly mako wlogout swaylock grim swappy waybar alacritty swaybg firefox brave-bin
```

### OPTION 2

[Manual Arch Configuration](https://github.com/jokyv/arch_installation/wiki/Manual-Arch-Configuration)

## Install rust via rustup and rust apps via cargo

```
cd arch_installation
./rust_helper.sh
```

## Install wm applications and my configs

```
cd arch_installation
./my_configs.sh
```

## Install all python libraries using uv

```
cd arch_installation
./python_helper.sh
```

#### How to create a swap file manually

```bash
# always create a swap file as RAM can cache more data, put it in home directory.
sudo dd if=/dev/zero of=/swapfile bs=1M count=1024000 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -m
sudo nvim /etc/fstab
# swapfile details
/swapfile none swap defaults 0 0

## if you want to remove a swap file
sudo swapoff -v /swapfile
sudo rm /swapfile
delete the swapfile line in fstab file
```

#### Useful pacman commands

```bash
man pacman
pacman -S # sync for install or update packages
pacman -R # remove packages
pacman -Q # look for local packages

pacman -S neovim # to install neovim
pacman -Sy # only sync your database
pacman -Syu # sync and update your programs - recommended
pacman -Syyu # passing two -y flags forces pacman to refresh package list
pacman -Syuw # sync and download the programs but doesnt install
pacman -Ss neo # search for any program that is available and that has 'neo' 

pacman -R neovim # remove program neovim (will not remove dependencies)
pacman -Rs neovim # will remove neovim and its dependencies
pacman -Rns neovim # remove also the config files - recommended

pacman -Q # lists every single package you have installed
pacman -Q | wc -l # count how many programs you have installed
pacman -Qe | wc -l # it is showing you all the programs you have installed
pacman -Qeq # list of all programs you have installed with only the names - recommended
pacman -Qn # all programs installed from main repos
pacman -Qm # all programs installed via the AUR
pacman -Qdt # dependencies that my system doesnt need anymore - most of time :)
pacman -Qs neo # searches something with neo for local packages

sudo nvim /etc/pacman.conf # uncomment color, ParallelDownloads VerbosePkgLists
```
