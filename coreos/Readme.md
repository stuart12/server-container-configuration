# Random notes on how to use ignition to configure a CoreOS Instance
## add options to rootfs for TRIM and compression
edited /usr/share/oem/grub.cfg, added "rootflags=rw,discard,compress=zstd" but should
follow [Kernel modules / sysctl parameters](https://coreos.com/os/docs/latest/other-settings.html)
section "Adding custom kernel boot options".

## Fix problem default route via eth1 on HostHatch.com

The DHCP server on eth1 gives returns a default route via eth1 but eth1 does not forward to the Internet.
Need to delete it on the console:

	sudo route del default

## CoreOS
	sudo passwd -l core
	scp ignition.json hh: # on local
	sudo dd if=/dev/zero of=/dev/sda10 bs=1M status=progress
	sudo dd if=/dev/zero of=/dev/sda9 bs=1M status=progress
	sudo coreos-install -d /dev/sda -i ignition.json -v

## test locally first

	: master; kvm -boot once=d -m 3G -drive file=hda,index=0,media=disk,format=raw  -cdrom coreos_production_iso_image.iso  -netdev user,id=user.0,hostfwd=tcp::5555-:22 -device e1000,netdev=user.0 -display  curses

## After install create a snapshot of the install state
	sudo btrfs subvol create /snapshots
	sudo btrfs subvol create /snapshots/rootfs
	sudo btrfs subvol snapshot -r / /snapshots/rootfs/first

## create snapshpt
    sudo btrfs subvol snapshot -r / /snapshots/rootfs/$(date -Iseconds)
