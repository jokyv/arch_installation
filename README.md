# arch installation

### Download Arch iso from the following link:
https://archlinux.org/download/
### Use the below command to write the iso into a usb stick

### first check if you have internet
- should not work unless you use wire internet 
```
- ping google.com
- if no wifi follow this: https://wiki.archlinux.org/index.php/Iwd#iwctl
```
### check the time is correct
```
- timedatectl set-ntp true
- timedatectl status
- date
```
### partion the disk using fdisk - for help press "m"
```
- lsblk
- fdisk -l
- fdisk /dev/sda
- g
- n
- 1
- 2048
- +550M
- n 
- 2
- default
- +20G
- n
- 3
- default
- ENTER
- w (to write)
- lsblk
```
### format the partitions
```
- mkfs.fat -F32 /dev/sda1
- mkfs.ext4 /dev/sda2
- mkfs.ext4 /dev/sda3
```
### mount the particion
```
- mount /dev/sda2 /mnt
- mkdir /mnt/home
- mount /dev/sda3 /mnt/home
- lsblk
```
### Install the absolute basic packages into /mnt
```
- pacstrap /mnt base base-devel linux linux-firmware git neovim amd-ucode
- Generate the FSTAB file with "genfstab -U /mnt >> /mnt/etc/FSTAB"
- cat /mnt/etc/FSTAB
```
### run the basic_config script
```
- Chroot into /mnt with "arch-chroot /mnt /bin/bash"
- Download the git repository into your HOME with:
- git clone https://github.com/jokyv/arch_installation
- cd arch_installation
- chmod +x basic_config.sh
- run script as: "./basic_config.sh"
```
#### Below are old notes to configure manually
#### merge those into basic_config.sh if anything is missing
```
- ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
- hwclock --systohc --utc
- nvim /etc/locale.gen
- /en_US.UTF-8 (uncomment this line)
- echo LANG=en_US.UTF-8 > /etc/locale.conf
- locale-gen

- nvim /etc/hostname and type arch
- nvim /etc/hosts
- 127.0.0.1 localhost.localdomain arch

- passwd
- add your password
- useradd -m -g users -G wheel -s /bin/bash someusername
- passwd someusername
- add pass for user someusername
- usermod -aG wheel,audio,video,optical,storage someusername
- pacman -S sudo
- visudo
- /%wheel ALL=(ALL) ALL (uncomment)

- pacman -S grub efibootmgr
- mkdir /boot/EFI
- mount /dev/sda1 /boot/EFI/
- lsblk
- grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
- grub-mkconfig -o /boot/grub/grub.cfg
- pacman -S networkmanager
- systemctl enable NetworkManager

- exit
- umount -R /mnt
- reboot
- log in with your someusername
- fix internet following the: https://wiki.archlinux.org/index.php/NetworkManager
```
### create a swap file *add it into the beginning instead*
```
# always create a swap file as RAM can cache more data, put it on home directory.
- sudo dd if=/dev/zero of=/swapfile bs=1024 count=10485760
- sudo chmod 600 /swapfile
- sudo mkswap /swapfile
- sudo swapon /swapfile
- free -m
- sudo nvim /etc/fstab
- # swapfile
- /swapfile none swap sw 0 0

- # if you want to remove a swap file
- sudo swapoff -v /swapfile
- sudo rm /swapfile
- delete the swapfile line in fstab file
```
### install essential applications like window manager and useful applications
```
- sudo pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server nitrogen picom neovim alacritty firefox feh flameshot cronie fzf tmux
- cd
- git clone https://aur.archlinux.org/paru.git
- cd paru
= makepkg -si
- cd ..
- rm -rf paru
- reboot
```
### install all Rust applications i am currently using
- fd, rg, procs, bat, exa, starship, alacritty

