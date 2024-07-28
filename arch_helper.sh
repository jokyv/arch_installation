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
    echo "later can change password with passwd root command"
}

#  NOTE:
# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

install_packages() {
    pacman=(
    acpi 
    acpi_call 
    acpid 
    alacritty 
    alsa-utils 
    avahi 
    base-devel # important
    bash-completion 
    bluez 
    bluez-utils 
    bridge-utils 
    cliphist
    cronie 
    cups 
    dialog 
    dnsmasq 
    dnsutils 
    dosfstools 
    edk2-ovmf 
    efibootmgr # important
    firefox 
    firewalld 
    fuzzel
    fzf 
    grim 
    grub # important
    gvfs 
    gvfs-smb 
    hplip 
    inetutils 
    ipset 
    linux-headers 
    ly 
    mako 
    mtools 
    nautilus 
    network-manager-applet 
    networkmanager # important unless we use iwd
    nfs-utils 
    niri
    nss-mdns 
    ntfs-3g
    openbsd-netcat 
    openssh 
    os-prober 
    pulseaudio 
    pulseaudio-alsa 
    python
    python-pip
    qemu 
    qemu-arch-extra 
    reflector 
    sof-firmware 
    swappy 
    swaybg # or swww
    swaylock 
    tlp 
    vde2 
    virt-manager 
    waybar 
    wl-clipboard 
    wlogout 
    wpa_supplicant 
    xdg-user-dirs 
    xdg-utils 
    yazi
    zathura    
    # fonts to install
    otf-font-awesome
    otf-firamono-nerd
    ttf-firacode-nerd
    ttf-hack-nerd
    ttf-nerd-fonts-symbols
    ttf-nerd-fonts-symbols-common
    # rust based apps
    alacritty
    atuin
    bat
    eza
    fd
    git-cliff
    git-delta
    ripgrep
    skim
    starship
    taplo-cli
    tokei
    typos    
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
    # grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
}

enable_systems() {
    systemctl enable NetworkManager # for the wifi connection
    systemctl enable bluetooth # for bluetooth
    systemctl enable cups.service
    systemctl enable sshd
    systemctl enable avahi-daemon
    systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
    systemctl enable reflector.timer
    systemctl enable fstrim.timer
    systemctl enable libvirtd
    systemctl enable firewalld
    systemctl enable acpid
    systemctl enable systemd-timesyncd.service
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
