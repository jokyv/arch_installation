# arch_installation
Arch Linux installation guide

## check if you have internet 
- ping google.com

## check the time is correct
- timedatectl set-ntp true
- timedatectl status

## partion the disk - for help press "m"
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
- +10G
- n
- 3
- default
- ENTER
-t change the particition type
- 1
- 1
- t
- 2
- 19
- w (to write)

## make our file system
- mkfs.fat -f32 /dev/sda1
- mkswap /dev/sda2
- swapon /dev/sda2
- mkfs.ext4 /dev/sda3

## mount the particion
- mount /dev/sda3 /mnt

- pacstrap /mnt base linux linux-firmware neovim
- genfstab -U /mnt >> /mnt/etc/fstab
- arch chroot /mnt

- ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
- hwclock --systohc
- pacman -S neovim (if neovim wasnt installed)
- nvim /etc/locale.gen
- /en_US.UTF-8 (uncomment this line)
- locale-gen

- nvim /etc/hostname
- arch
- nvim /etc/hosts
- 127.0.0.1 localhost
- ::1       locahost
- 127.0.1.1 archvbox.localdomain  archvbox

- passwd
- add your password
- useradd -m jokyv
- passwd jokyv
- add pass for user jokyv
- usermod -aG wheel,audio,video,optical,storage jokyv
- pacman -S sudo
- visudo
- /%wheel ALL=(ALL) NOPASSWD: ALL (uncomment)
- pacman -S grub efibootmgr dosfstools os-prober atools
- mkdir /boot/EFI
- mount /dev/sda1 /boot/EFI
- grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
- grub-mkconfig -o /boot/grub/grub.cfg
- pacman -S networkmanager git
- systemctl enable NetworkManager
- exit
- umount /mnt
- reboot
