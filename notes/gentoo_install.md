# Networking
- Uses wpa_supplicant
    - look up section in gentoo wireless networking, wpa_supplicant
    - need to modify /etc/wpa_supplicant/wpa_supplicant.conf && /etc/conf.d/net

            - /etc/wpa_supplicant/wpa_supplicant.conf
                \# The below line not be changed otherwise wpa_supplicant refuses to work
                ctrl_interface=/var/run/wpa_supplicant
                \# Ensure that only root can read the WPA configuration
                ctrl_interface_group=0
                \# Let wpa_supplicant take care of scanning and AP selection
                ap_scan=1
                network={
                  ssid="simple"
                  psk="very secret passphrase"
                }

            - /etc/conf.d/net
                - modules="wpa_supplicant"

    - generate a wpa psk with `wpa_passphrase {network ssid} {passphrase}`
        - e.g., `echo wpa_passphrase "my_network_name" "my_password" >> /etc/wpa_supplicant/wpa_supplicant.conf`
    - after adding network, to relaunch wpa_supplicant, ps aux and kill the process
    - launch wpa_supplicant with device and config:
        - e.g., `wpa_supplicant -i wsx8s8 -c /etc/wpa_supplicant/wpa_supplicant.conf`


# Prepare the disk
    1. ensure device-mapper kernel module is loaded:
        - `modprobe dm-mod`
    2. format disk:
        - `cfdisk /dev/sda`
        - choose dos (if no label), then single primary partition, and write it
    3. setup encrytpted volume (from parabola wiki)
        - # `cryptsetup -v --cipher serpent-xts-plain64 --key-size 512 --hash whirlpool --iter-time 500 --use-random --verify-passphrase luksFormat /dev/sdXY`
    4. open luks partition:
        - `cryptsetup luksOpen /dev/sda2 lvm`
    5. create LVM partition:
        - `pvcreate /dev/mapper/lvm`
        - check with `pvdisplay`
    6. create volume groups, inside of which the volumes will be created
        - `vgcreate {vg-name} /dev/mapper/lvm`
        - check with `vgdisplay`
    7. create the logical volumes themselves:
        - for swap: `lvcreate -L 4G {vg-name} -n swapvol`
        - for root: `lvcreate -l +100%FREE {vg-name} -n rootvol`
        - check with `lvdisplay`
    8. make rootvol and swapvol ready for installation
        - `mkswap /dev/mapper/{vg-name}-swapvol`
        - `swapon /dev/{vg-name}/swapvol`

        - `mkfs.ext4 /dev/mapper/{vg-name}-rootvol`
        - `mount /dev/{vg-name}/rootvol /mnt/gentoo`

## LVM management
    - note: may need to `cryptsetup luksOpen /dev/sda1 lvm` to decrypt drive before mounting logical volumes
    - `vgscan` - will locate logical volume groups
    - `vgchange -ay VolumeGroup01` - activate a LV
    - `lvs` - list logical volumes
    - `mount /dev/VolumeGroup01/rootvol /mnt/gentoo` - mount the LV 
    - `swapon -v /dev/mapper/VolumeGroup01-swap` - activate the swap partition

# Installing a stage tarball

## set date if needed
- either manually: 
    - `date MMDDhhmmYYYY`
- or automatically: 
    - `ntpd -q -g`

## download stage tarball
- go to dir where root is mounted: 
    -`cd /mnt/gentoo`
- open browser to dl tar: 
    - `links https://www.gentoo.org/downloads/mirrors`
    - nav to 'releases/amd64/autobuilds/' and download preferred tarbal with `d`
- check validity of tar with: 
    - `sha512 sum {tar_name}, compare to DIGESTS file`
- unpack tarball: 
    -  `tar xpf {tar_name} --xattrs-include='*.*' --numeric-owner`
- modify /mnt/gentoo/etc/portage/make.conf to this:
    - `CFLAGS="-march-native -O2 -pipe" `
    - `CXXFLAGS="${CFLAGS}"`
    - `MAKEOPTS="-j3"`  # where 3 is the number of system cores + 1

# Install the base system
1. select mirrors: 
    - `mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf`
2. make repo dir: 
    - `mkdir --parents /mnt/gentoo/etc/portage/repos.conf`
3. copy gentoo-provided config to new dir: 
    - `cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf`
4.  copy resolve.conf to new install: 
    - `cp --dereference /etc/resolv.conf /mnt/gentoo/etc/`
5. mount proc, sys, dev:
    - `mount --types proc /proc /mnt/gentoo/proc`
    - `mount --rbind /sys /mnt/gentoo/sys`
    - `mount --rbind /dev /mnt/gentoo/dev`
6. enter new environment:
    - `chroot /mnt/gentoo /bin/bash`
    - `source /etc/profile`
    - `export PS1="(chroot) ${PS1}"`
0. if librebooting, specify licenses (can be done anytime before emerging additional packages)
    - `echo 'ACCEPT_LICENSE="-* @FREE"' >> /etc/portage/make.conf`
7. install an ebuild repository snapshot from web:
    - `emerge-webrsync`
8.  configure USE flags if necessary:
   - edit /etc/portage/make.conf
9. optional: change profile if desired:
    - `eselect profile list`
    - `eselect profile set {num or name}`
10. specify timezone:
    - `ls /usr/share/zoneinfo`
    - `echo "America/New_York > /etc/timezone"`
    - `emerge --config sys-libs/timezone-data`
11. configure locales:
    - `vim /etc/locale.gen`
    - `locale-gen`
    - `eselect locale list`
    - `eselect locale set 5`
12. update the environment
    - `env-update && source /etc/profile && export PS1="(chroot) $PS1"`

# Configure the Kernel

1. download the file from linux-libre:
    - `links https://linux-libre.fsfla.org/pub/linux-libre/releases`
2. extract kernel, preserving permissions etc:
    - `tar xvjpf linux-libre-3.19-gnu.tar.bz2`
3. symlink source code to /usr/src/linux dir:
    - from within root of chroot, note no trailing slashes for dirs:
    - `ln -s /linux-3.19.1 /usr/src/linux`
4. configure kernel:
    - `make menuconfig`
5. build kernel (may need to install bc first...)
    - `make && modules install`
6. install new kernel
    - `make install`
---- currently at the point of creating a initramfs... need to find a libre solution

note: to resume install process
    - `cryptsetup luksOpen /dev/sda1 lvm` - decrypt drive before mounting logical volumes
    - `vgscan` - will locate logical volume groups
    - `vgchange -ay VolumeGroup01` - activate a LV
    - `lvs` - list logical volumes
    - `mount /dev/VolumeGroup01/rootvol /mnt/gentoo` - mount the LV 
    - `swapon -v /dev/mapper/VolumeGroup01-swap` - activate the swap partition
    - resume at "install the base system, step 4", which is dns copying


