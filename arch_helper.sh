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

install_packages() {
    pacman=(
    # acpi 
    # acpi_call 
    # acpid 
    amd-ucode
    alsa-utils 
    alsa-firmware
    atuin
    avahi 
    base
    base-devel # important
    bash-completion 
    bash-language-server
    bat
    blueman
    bluez 
    bluez-utils 
    bridge-utils 
    chrono-date
    cliphist
    cmake
    cronie 
    cups 
    discord
    htop
    obsidian
    pavucontrol
    slurp
    dialog 
    dnsmasq 
    dnsutils 
    dosfstools 
    edk2-ovmf 
    efibootmgr # important
    eza
    wget
    wireless_tools
    fd
    firefox 
    firewalld 
    fuzzel
    fzf 
    git-cliff
    git-delta
    github-cli
    grim 
    grub # important
    gvfs 
    gvfs-smb 
    hplip 
    inetutils 
    ipset 
    kitty
    linux-headers 
    ly 
    mako 
    marksman
    mtools 
    nautilus 
    network-manager-applet 
    networkmanager # important unless we use iwd
    nfs-utils 
    niri
    nix
    nss-mdns 
    ntfs-3g
    openbsd-netcat 
    openssh 
    os-prober 
    pulseaudio 
    pulseaudio-alsa 
    python
    python-pip
    python-rich
    qemu 
    qemu-arch-extra 
    reflector 
    ripgrep
    skim
    sof-firmware 
    starship
    swappy 
    swaybg # or swww
    swaylock 
    taplo-cli
    tlp 
    tokei
    typos    
    uv
    vde2 
    virt-manager 
    vscode-json-languageserver
    waybar 
    wl-clipboard 
    wlogout 
    wpa_supplicant 
    xdg-user-dirs 
    xdg-utils 
    yaml-language-server
    yazi
    zathura    
    # fonts to install
    awesome-terminal-fonts
    otf-font-awesome
    otf-firamono-nerd
    ttf-firacode-nerd
    ttf-hack-nerd
    ttf-nerd-fonts-symbols
    ttf-nerd-fonts-symbols-common
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
