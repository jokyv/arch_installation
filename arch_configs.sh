#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
hwclock --systohc --utc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
## change the keymap for the keyboard
#echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

# or can do 
pacman=(
acpi 
acpi_call 
acpid 
alsa-utils 
avahi 
base-devel 
bash-completion 
bluez 
bluez-utils 
bridge-utils 
cups 
dialog 
dnsmasq 
dnsutils 
dosfstools 
edk2-ovmf 
efibootmgr 
firewalld 
flatpak 
grub 
gvfs 
gvfs-smb 
hplip 
inetutils 
ipset 
iptables-nft 
linux-headers 
mtools 
network-manager-applet 
networkmanager 
nfs-utils 
nss-mdns 
ntfs-3g 
openbsd-netcat 
openssh 
os-prober 
pipewire 
pipewire-alsa 
pipewire-jack 
pipewire-pulse 
qemu 
qemu-arch-extra 
reflector 
rsync 
sof-firmware 
terminus-font
tlp 
vde2 
virt-manager 
wpa_supplicant 
xdg-user-dirs 
xdg-utils 
#sudo
#visudo
#cronie
)

sudo pacman -S ${pacman[@]}

# AMD GPU
# pacman -S --noconfirm xf86-video-amdgpu
# NVIDIA GPU
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

#  FIXME: does it require to add user to wheel?
useradd -m jokyv
echo jokyv:password | chpasswd
usermod -aG libvirt jokyv

echo "jokyv ALL=(ALL) ALL" >> /etc/sudoers.d/jokyv

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
