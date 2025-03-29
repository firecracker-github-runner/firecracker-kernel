# firecracker-kernel

Automated builds of the Linux Kernel with Firecracker MicroVM's configuration.

## What?

Automated builds of the linux kernel with Firecracker's recommended kernel configuration (https://github.com/firecracker-microvm/firecracker/blob/main/resources/guest_configs/).

More or less, this is automating the steps in https://github.com/firecracker-microvm/firecracker/blob/main/docs/rootfs-and-kernel-setup.md#creating-a-kernel-image

## Why?

While Firecracker does have links to a vmlinux.bin in their docs, there's little documentation on the provenance. This provides a compatible kernel that is reasonably up to date and where the sourcing is at least somewhat verifiable.

## License

This repository's contents are licensed under GPL-2.0. 

The Linux Kernel and the resulting binary are licensed like all Linux Kernels (GPL-2.0, with some exceptions): https://github.com/torvalds/linux/blob/master/COPYING
