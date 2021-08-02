# Arch installation

### TODOs for v1.0
- /etc/pacman.conf save it to your dotfiles!
- where to put user-dirs.dirs?

### Download Arch ISO from the below link:
https://archlinux.org/download/

### Use the below command to write the ISO into a USB drive.
#### Instructions can be found on this [link](https://wiki.archlinux.org/title/USB_flash_installation_medium).

```
dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/sdx conv=fsync oflag=direct status=progress
````

### first check if you have internet
- internet should not work unless you use wire 
- if no internet follow instructions on this [link](https://wiki.archlinux.org/index.php/Iwd#iwctl)
```
ping google.com
iwctl
device list
station wlan0 connect <wifi name>
pacman -Syy
```

### check the time is correct
```
timedatectl set-ntp true
timedatectl status
date
```

### partition the disk using cgdisk.
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

### format the partitions
```
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

### mount the partitions
```
mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi
mkdir /mnt/home
mount /dev/nvme0n1p3 /mnt/home
lsblk
```

### Install the absolute basic packages
```
pacstrap /mnt base base-devel linux linux-firmware git neovim amd-ucode
# Generate the FSTAB file with 
genfstab -U /mnt >> /mnt/etc/FSTAB
cat /mnt/etc/FSTAB
```

### arch chroot
```
# Chroot into /mnt with...
arch-chroot /mnt /bin/bash
```

### create a swap file
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

### install more essential applications (wm and xorg)
```
cd ~
sudo pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server nitrogen picom alacritty firefox feh flameshot cronie fzf tmux bspwm sxhkd
exit
umount -a
reboot
```

### If no internet after rebooting
- follow this [link](https://wiki.archlinux.org/index.php/NetworkManager)

### Download help installation repo into your HOME directory:
```
git clone https://github.com/jokyv/arch_installation
cd arch_installation
chmod +x basic_config.sh
./basic_config.sh
```

### install all python libraries using pip
```
pip_packages = (
pandas
numpy
matplotlib
tqdm
scikit-learn
)
pip install $pip_packages
```

### install all Rust applications using cargo
```
# install rustup and rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install fd ripgrep procs bat exa starship alacritty tokei cargo-update?
```
