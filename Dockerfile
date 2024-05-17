FROM denoland/deno:bin@sha256:c502d01787012a4a2b21fe0f26b707a289aba85c2c51a60dfd733f233dfce22c AS deno

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
