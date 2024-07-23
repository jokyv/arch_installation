# Arch installation

- Download Arch ISO from the following [link](https://archlinux.org/download/)
- Write the ISO into a USB drive using the command:

```console
dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/sdx conv=fsync oflag=direct status=progress
````

- following instructions on [link](https://wiki.archlinux.org/title/USB_flash_installation_medium).
- Check if you have internet

```console
ping -c 3 archlinux.org
```

- if no internet follow instructions on this [link](https://wiki.archlinux.org/index.php/Iwd#iwctl)

```bash
iwctl
device list
station wlan0 connect <wifi name>
exit
```

- Enable parallel by uncommenting the ParallelDOwnloads variable.

```console
nano /etc/pacman.conf
```

### OPTION 1

```console
archinstall
```

```
reflector -c Singapore -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

#### Depedencies

```
niri fuzzel cliphist wl-clipboard zathura nautilus ly mako wlogout swaylock grim swappy waybar alacritty swaybg firefox brave-bin
```

### OPTION 2

[Manual Arch Configuration](https://github.com/jokyv/arch_installation/wiki/Manual-Arch-Configuration)

## Niri settings

Make a link to wallpaper:
`ln -sf ~/pics/wallpapers/purple_view.png ~/.config/niri/wallpaper`

Needed services:
```console
mkdir -p                                               ~/.config/systemd/user/niri.service.wants
ln -s ~/.config/systemd/user/cliphist.service          ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/darkman.service           ~/.config/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/mako.service               ~/.config/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/gnome-polkit-agent.service ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/playctld.service          ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/swaybg.service            ~/.config/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/waybar.service             ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/wlsunset.service          ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/ydotool.service           ~/.config/systemd/user/niri.service.wants/
```
## Install rust via rustup and all rust apps via cargo
```
cd arch_installation
./rust_helper.sh
```

## Install all python libraries using pip
```
cd arch_installation
./python_helper.sh

```
## Install wm applications and my configs
```
cd arch_installation
./my_configs.sh
```

#### How to create a swap file manually
```
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
