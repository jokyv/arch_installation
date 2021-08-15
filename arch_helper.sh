#!/bin/bash

# arch basic configurations/installations

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

basic_configs() {
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
}

#  NOTE:
# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

install_packages() {
    pacman=(
    #sudo
    #visudo
    acpi 
    acpi_call 
    acpid 
    alsa-utils 
    avahi 
    bash-completion 
    base-devel     
    bluez 
    bluez-utils 
    bridge-utils 
    bspwm 
    cronie 
    cups 
    dialog 
    dnsmasq 
    dnsutils 
    dosfstools 
    edk2-ovmf 
    efibootmgr 
    feh 
    firefox 
    firewalld 
    flameshot 
    flatpak 
    fzf 
    grub 
    gvfs 
    gvfs-smb 
    hplip 
    inetutils 
    ipset 
    lazygit
    linux-headers 
    mtools 
    network-manager-applet 
    networkmanager 
    nfs-utils 
    nitrogen 
    nodejs
    npm
    nss-mdns 
    ntfs-3g
    openbsd-netcat 
    openssh 
    os-prober 
    picom 
    pulseaudio 
    pulseaudio-alsa 
    python
    python-pip
    qemu 
    qemu-arch-extra 
    reflector 
    rsync 
    sof-firmware 
    sxhkd
    terminus-font
    tlp 
    tmux 
    vde2 
    virt-manager 
    wpa_supplicant 
    xdg-user-dirs 
    xdg-utils 
    xorg 
    xorg-server 
    xorg-xinit 
    )

    sudo pacman -S ${pacman[@]}
    
    # AMD GPU
    # pacman -S --noconfirm xf86-video-amdgpu
    # NVIDIA GPU
    sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
}

grub_config() {
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
}

enable_systems() {
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
}

add_user() {
    useradd -m jokyv
    passwd jokyv
    #echo jokyv:password | chpasswd
    usermod -aG libvirt jokyv
    echo "jokyv ALL=(ALL) ALL" >> /etc/sudoers.d/jokyv
}

# basic configuration
basic_configs
# install important pacman packages
install_packages
# grub configuration
grub_config
# enable systmctl 
enable_systems
# add user jokyv
add_user

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
