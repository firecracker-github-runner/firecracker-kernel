#!/bin/bash

set -eE -o pipefail

dest_path="dist"
working_path="working"
kernel_version=$(cat "versions/kernel")
firecracker_version=$(cat "versions/firecracker")

get_kernel() {
	pushd "${working_path}" >> /dev/null

	major_version=$(echo "${kernel_version}" | cut -d. -f1)
	kernel_tarball="linux-${kernel_version}.tar.xz"

	if [ ! -f sha256sums.asc ] || ! grep -q "${kernel_tarball}" sha256sums.asc; then
		shasum_url="https://cdn.kernel.org/pub/linux/kernel/v${major_version}.x/sha256sums.asc"
		echo "Download kernel checksum file: sha256sums.asc from ${shasum_url}"
		curl --fail -OL "${shasum_url}"
	fi
	grep "${kernel_tarball}" sha256sums.asc >"${kernel_tarball}.sha256"

	if [ -f "${kernel_tarball}" ] && ! sha256sum -c "${kernel_tarball}.sha256"; then
		echo "invalid kernel tarball ${kernel_tarball} removing "
		rm -f "${kernel_tarball}"
	fi
	if [ ! -f "${kernel_tarball}" ]; then
		echo "Download kernel version ${kernel_version}"
		echo "Download kernel"
		curl --fail -OL "https://www.kernel.org/pub/linux/kernel/v${major_version}.x/${kernel_tarball}"
	else
		echo "kernel tarball already downloaded"
	fi

	sha256sum -c "${kernel_tarball}.sha256"

	tar xf "${kernel_tarball}"

	mv "linux-${kernel_version}" "kernel"

	popd >> /dev/null
}

get_kernel_config() {
	pushd "${working_path}/kernel" >> /dev/null

	curl --fail -OL "https://raw.githubusercontent.com/firecracker-microvm/firecracker/${firecracker_version}/resources/guest_configs/microvm-kernel-x86_64-5.10.config"
    mv microvm-kernel-x86_64-5.10.config .config
	make olddefconfig

	popd >> /dev/null
}

build_kernel() {
	pushd "${working_path}/kernel" >> /dev/null

	make -j $(nproc ${CI:+--ignore 1}) ARCH="x86_64" vmlinux

	popd >> /dev/null
}

main()
{
    mkdir -p ${working_path}
	mkdir -p ${dest_path}
	
    get_kernel
	get_kernel_config
	build_kernel

    cp ${working_path}/kernel/vmlinux ${dest_path}/vmlinux
}

main "$@"