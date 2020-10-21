# arch_installation
Arch Linux installation guide

### check if you have internet (shouldnt work)
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
### partion the disk - for help press "m"
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
### make our file system
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

- pacstrap /mnt base base-devel linux linux-firmware neovim git
- genfstab -U /mnt >> /mnt/etc/fstab
- cat /mnt/etc/fstab
- arch-chroot /mnt /bin/bash

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
### swap file
```
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
### install window manager
```
- sudo pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server nitrogen picom neovim alacritty firefox 
- cd
```
### setup yay
```
- git clone https://aur.archlinux.org/yay-git.git
- cd yay-git
- makepkg -si
- reboot
```

