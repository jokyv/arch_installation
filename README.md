# Arch installation

## TODOs for v1.0

- [ ] Move to [Hyprland](https://github.com/hyprwm/Hyprland)
- [ ] Move to [pyenv](https://github.com/pyenv/pyenv)
- [ ] /etc/pacman.conf save it to your dotfiles!
- [ ] where to put user-dirs.dirs?
- [ ] find the best mirrors to download packages
- [x] create alias for pip update all packages
- [x] move to python-lsp-server with ruff and black as plugins

### Download Arch ISO from the below link:

- https://archlinux.org/download/

### Use the below command to write the ISO into a USB drive.

- Instructions can be found on this [link](https://wiki.archlinux.org/title/USB_flash_installation_medium).
```
dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/sdx conv=fsync oflag=direct status=progress
````

#### First check if you have internet

- if no internet follow instructions on this [link](https://wiki.archlinux.org/index.php/Iwd#iwctl)
```
ping google.com
iwctl
device list
station wlan0 connect <wifi name>
exit
pacman -Sy
```

### OPTION 1

```
archinstall
```

```
reflector -c Singapore -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

### OPTION 2

#### Check the time is correct
```
timedatectl set-ntp true
timedatectl status
date
```

#### Partition the disk using cgdisk.
```
lsblk
cgdisk /dev/nvme0n1
# delete any partitions you do not need
# select 'free space' and...
NEW - ENTER - 300MB - ef00 - efilinux - ENTER
NEW - ENTER - ENTER - 8300 - root - ENTER
WRITE - ENTER - yes
QUIT - ENTER
lsblk
```

#### Partition the disk using gdisk 
- preferred method
```
lsblk
gdisk /dev/nvme0n1
n - ENTER - ENTER - +250M - ef00  # for EFI
n - ENTER - ENTER -  +16G - 8200  # for swap partition
n - ENTER - ENTER -  +20G - ENTER # for root partition
n - ENTER - ENTER - ENTER - ENTER # home partition
w # to write the changes
y # to confirm with the changes
lsblk
```

#### Format the partitions
```
mkfs.vfat /dev/nvme0n1p1 - ENTER
# OR
mkfs.fat -F32 /dev/nvme0n1p1 - ENTER

mkswap /dev/nvme0n1p2 - ENTER
swapon /dev/nvme0n1p2 - ENTER

mkfs.ext4 /dev/nvme0n1p3 - ENTER
mkfs.ext4 /dev/nvme0n1p4 - ENTER
lsblk
```

#### Mount the partitions
```
mount /dev/nvme0n1p3 /mnt # installation directory
mkdir -p /mnt/boot/efi
mkdir /mnt/home
mount /dev/nvme0n1p1 /mnt/boot/efi
mount /dev/nvme0n1p4 /mnt/home
lsblk
```

#### Install the absolute basic packages
```
pacstrap /mnt base linux linux-firmware git neovim amd-ucode
```

#### Generate the FSTAB file with 
```
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
```

#### Then chroot into /mnt
```
arch-chroot /mnt /bin/bash
```

### *WARNING*, i need to generate the public key!
#### Download help installation repo into your HOME directory:
```
cd ~
git clone git@github.com:jokyv/arch_installation.git
cd arch_installation
ls -l # check if you need to chmod the scripts
chmod +x arch_helper.sh
./arch_helper.sh
```

#### Final steps
```
exit
umount -a
umount -R /mnt
reboot
```

#### If no internet after rebooting
- follow this [link](https://wiki.archlinux.org/index.php/NetworkManager)

#### Install rust via rustup and all rust apps via cargo
```
cd arch_installation
./rust_helper.sh
```

#### Install all python libraries using pip
```
cd arch_installation
./python_helper.sh

```
#### Install xorg, bspwm, sxhkd, polybar and useful apps and configurations
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

## Misc
#### pacman commands
```
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

sudo nvim /etc/pacman.conf # uncomment color and VerbosePkgLists
```
