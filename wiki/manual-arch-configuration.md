# Manual Arch configuration

## Check the time is correct
```bash
timedatectl set-ntp true
timedatectl status
date
```

## Partition the disk using cgdisk.
```bash
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

## Partition the disk using gdisk 
- preferred method
```bash
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
```bash
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
```bash
mount /dev/nvme0n1p3 /mnt # installation directory
mkdir -p /mnt/boot/efi
mkdir /mnt/home
mount /dev/nvme0n1p1 /mnt/boot/efi
mount /dev/nvme0n1p4 /mnt/home
lsblk
```

#### Install the absolute basic packages
```bash
pacstrap /mnt base linux linux-firmware git neovim amd-ucode
```

#### Generate the FSTAB file with 
```bash
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
```

#### Then chroot into /mnt
```bash
arch-chroot /mnt /bin/bash
```

### *WARNING*, i need to generate the public key!
#### Download help installation repo into your HOME directory:
```bash
cd ~
git clone git@github.com:jokyv/arch_installation.git
cd arch_installation
ls -l # check if you need to chmod the scripts
chmod +x arch_helper.sh
./arch_helper.sh
```

#### Final steps
```bash
exit
umount -a
umount -R /mnt
reboot
```

#### If no internet after rebooting
- follow this [link](https://wiki.archlinux.org/index.php/NetworkManager)
