# arch_installation
Arch Linux installation guide

## check if you have internet (shouldnt work)
- ping google.com
- if no wifi follow this: https://wiki.archlinux.org/index.php/Iwd#iwctl

## check the time is correct
- timedatectl set-ntp true
- timedatectl status
- date

## partion the disk - for help press "m"
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

## make our file system
- mkfs.fat -F32 /dev/sda1
- mkfs.ext4 /dev/sda2
- mkfs.ext4 /dev/sda3

## mount the particion
- mount /dev/sda3 /mnt

- pacstrap /mnt base base-devel linux linux-firmware neovim git
- genfstab -U /mnt >> /mnt/etc/fstab
- arch chroot /mnt

- ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
- hwclock --systohc
- nvim /etc/locale.gen
- /en_US.UTF-8 (uncomment this line)
- locale-gen

- nvim /etc/hostname and type arch
- nvim /etc/hosts
- 127.0.0.1 localhost

- passwd
- add your password
- useradd -m someusername
- passwd someusername
- add pass for user someusername
- usermod -aG wheel,audio,video,optical,storage someusername
- pacman -S sudo
- visudo
- /%wheel ALL=(ALL) ALL (uncomment)
- pacman -S grub efibootmgr
- mkdir /boot/EFI
- mount /dev/sda1 /boot/EFI
- grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
- grub-mkconfig -o /boot/grub/grub.cfg
- pacman -S networkmanager
- systemctl enable NetworkManager
- exit
- umount /mnt
- reboot
- log in with your someusername
- fix internet following the: https://wiki.archlinux.org/index.php/NetworkManager

## install window manager
- sudo pacman -S xf86-video(?) xorg xorg-xinit nitrogen picom neovim alacritty firefox 
- cd

- git clone https://aur.archlinux.org/yay-git.git
- cd yay-git
- makepkg -si
- reboot


