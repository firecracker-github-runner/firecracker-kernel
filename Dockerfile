FROM denoland/deno:bin@sha256:df47d96531d13eb951b61e2bed244372e187517e66245a725b9cb259a0d53e70 AS deno

FROM fedora:latest@sha256:5ce8497aeea599bf6b54ab3979133923d82aaa4f6ca5ced1812611b197c79eb0

RUN dnf install -y \
    bc \
    bison \
    debootstrap \
    diffutils \
    e2fsprogs \
    elfutils-libelf-devel \
    findutils \
    flex \
    gcc \
    gcc-c++ \
    git \
    kiwi \
    kmod \
    openssl \
    openssl-devel \
    make \
    parted \
    patch \
    qemu-img \
    systemd-devel \
    sudo \
    unzip \
    xz \
    yasm && \
    dnf clean all

COPY --from=deno --chown=root:0 /deno /usr/bin/deno

RUN useradd builder -G 0 --create-home && \
    mkdir -p /working && \
    chown -R builder:0 /working

WORKDIR /working

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml ./LICENSE /working/

USER builder

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
