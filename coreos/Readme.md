# Random notes on how to use ignition to configure a CoreOS Instance

## Fix problem default route via eth1 on HostHatch.com

The DYHCP server on eth1  give us a default route via eth1 but eth1 does not forward to the Internet.

	sudo route del default

## CoreOS
	sudo passwd -l core
	scp ignition.json hh:
	sudo dd if=/dev/zero of=/dev/sda10 bs=1M status=progress
	sudo dd if=/dev/zero of=/dev/sda9 bs=1M status=progress
	sudo coreos-install -d /dev/sda -i ignition.json -v

## test locally first

	: master; kvm -boot once=d -m 3G -drive file=hda,index=0,media=disk,format=raw  -cdrom coreos_production_iso_image.iso  -netdev user,id=user.0,hostfwd=tcp::5555-:22 -device e1000,netdev=user.0 -display  curses

## create a snapshow of the install state
	sudo btrfs subvol create /snapshots
	sudo btrfs subvol create /snapshots/rootfs
	sudo btrfs subvol snapshot -r / /snapshots/rootfs/first





## Perhaps not a good idea

### Possible move of rootfs to a subvolume

	: ; sudo btrfs subvolume snapshot / /rootfs
	Create a snapshot of '/' in '//rootfs'
	: ; sudo mkdir -m 755 /snapshots
	: ; sudo btrfs subvolume list /
	ID 257 gen 8 top level 5 path srv
	ID 258 gen 9 top level 5 path var/lib/machines
	ID 259 gen 10 top level 5 path var/tmp
	ID 261 gen 22 top level 5 path rootfs
	: ; sudo btrfs subvolume set-default 261 /
	for i in var/tmp var/lib/machines srv; do sudo rmdir /rootfs/$i && sudo btrfs subvolume create /rootfs/$i && sudo chmod --reference /$i /rootfs/$i; done

	: ; sudo rm -r /rootfs/etc && sudo btrfs subvol create /rootfs/etc && sudo cp -a /etc/. /rootfs/etc/.

	core@localhost ~ $ sudo reboot

	: ; sudo mkdir /disks /disks/btrfs /disks/btrfs/toplevel
	: ; sudo mount  -o subvolid=0 /dev/sda9  /disks/btrfs/toplevel

	cd /disks/btrfs/toplevel
	sudo rm bin lib lib64 sbin
	sudo btrfs subvol delete srv var/lib/machines var/tmp
	sudo rm -r boot dev etc home media mnt proc root run sys tmp usr var

### move /etc to a subvolume

	cd snapshots
	sudo btrfs subvol create /disks/btrfs/toplevel/snapshots/etc
	sudo btrfs snapshot -r /etc /disks/btrfs/toplevel/snapshots/etc/original
	core@localhost /disks/btrfs/toplevel/snapshots/etc $ sudo btrfs subvol snapshot -r /etc /disks/btrfs/toplevel/snapshots/etc/original
