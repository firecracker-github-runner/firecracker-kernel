#!/bin/bash

set -eux -o pipefail

function get_kernel() {
  local working_path="$1"
  local kernel_version="$2"

  pushd "${working_path}" >>/dev/null

  major_version=$(echo "${kernel_version}" | cut -d. -f1)
  kernel_tarball="linux-${kernel_version}.tar.xz"

  if [ ! -f sha256sums.asc ] || ! grep -q "${kernel_tarball}" sha256sums.asc; then
    shasum_url="https://cdn.kernel.org/pub/linux/kernel/v${major_version}.x/sha256sums.asc"
    curl --fail -OL "${shasum_url}"
  fi
  grep "${kernel_tarball}" sha256sums.asc >"${kernel_tarball}.sha256"

  if [ -f "${kernel_tarball}" ] && ! sha256sum -c "${kernel_tarball}.sha256"; then
    echo "invalid kernel tarball ${kernel_tarball} removing "
    rm -f "${kernel_tarball}"
  fi
  if [ ! -f "${kernel_tarball}" ]; then
    curl --fail -OL "https://www.kernel.org/pub/linux/kernel/v${major_version}.x/${kernel_tarball}"
  else
    echo "kernel already downloaded"
  fi

  sha256sum -c "${kernel_tarball}.sha256"

  tar xf "${kernel_tarball}"
  mv "linux-${kernel_version}" "kernel"

  popd >>/dev/null
}

function get_kernel_config() {
  local working_path="$1"
  local firecracker_version="$2"

  pushd "${working_path}/kernel" >>/dev/null

  curl --fail -OL "https://raw.githubusercontent.com/firecracker-microvm/firecracker/${firecracker_version}/resources/guest_configs/microvm-kernel-ci-x86_64-5.10.config"
  mv microvm-kernel-ci-x86_64-*.config .config

  # Throw if .config somehow does not exist (olddefconfig will silently create it)
  if [ ! -f .config ]; then
    echo "No .config file found, aborting"
    exit 1
  fi

  make olddefconfig

  popd >>/dev/null
}

function build_kernel() {
  local working_path="$1"

  pushd "${working_path}/kernel" >>/dev/null

  # Allow skipping kernel build for testing
  if [ -n "${SKIP_KERNEL_BUILD}" ]; then
    echo "SKIP_KERNEL_BUILD is set, skipping kernel build"
    echo "test" >vmlinux
    popd >>/dev/null
    return
  fi

  # All of the contents of the tar are timestamped with the build time
  # We somewhat arbitrarily use Makefile's timestamp
  local timestamp=$(stat -c %Y Makefile)

  # see: https://docs.kernel.org/kbuild/reproducible-builds.html
  export KBUILD_BUILD_USER="firecracker-github-runner/firecracker-kernel"
  export KBUILD_BUILD_HOST="github-runner"
  export KBUILD_BUILD_TIMESTAMP="$(date -u -d "@${timestamp}" +"%Y-%m-%d %H:%M:%S %z")"

  make -j $(nproc ${CI:+--ignore 1}) ARCH="x86_64" vmlinux
  popd >>/dev/null
}

function main() {
  local kernel_version="$1"
  local firecracker_version="$2"
  local working_path="$3"
  local output_path="$4"

  # Init default values
  CI=${CI:-}
  SKIP_KERNEL_BUILD=${SKIP_KERNEL_BUILD:-}

  echo "CI: ${CI}"
  echo "SKIP_KERNEL_BUILD: ${SKIP_KERNEL_BUILD}"
  echo "pwd: $(pwd)"

  rm -r "${working_path}/kernel" || true
  rm "${output_path}" || true

  mkdir -p ${working_path}
  mkdir -p $(dirname ${output_path})

  get_kernel ${working_path} ${kernel_version}
  get_kernel_config ${working_path} ${firecracker_version}
  build_kernel ${working_path}

  mv ${working_path}/kernel/vmlinux ${output_path}
}

main "$@"
