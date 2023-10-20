FROM denoland/deno:bin@sha256:36d36d063788b8ca6d9ab10f43bb0861f159d7601c80929ec4f01db9900aad9b AS deno

FROM fedora:latest@sha256:8285246bd5fad4e76e17a71c88dee34c49e2f227dab4ce7df704b592f8e72d41

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
