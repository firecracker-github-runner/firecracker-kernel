FROM denoland/deno:bin@sha256:d6f1a86734ab3b9764f31872206e534e1e3190f9e35ca2b7b1a194aac58b834d AS deno

FROM fedora:latest@sha256:ee16ca86648f857c68270514442953c808c61c416152b9a316e551b02bedf8ec

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
