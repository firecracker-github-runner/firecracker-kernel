FROM fedora:latest@sha256:61f921e0c7b51e162e6f94b14ef4e6b0d38eac5987286fe4f52a2c1158cc2399

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
    xz \
    yasm && \
    dnf clean all

RUN useradd builder -G 0 && \
    mkdir -p /home/builder && \
    chown -R builder:0 /home/builder && \
    chmod -R g=u /home/builder

WORKDIR /home/builder

COPY --chown=root:0 ./build.sh ./
COPY --chown=root:0 ./versions ./versions

USER builder

CMD ["./build.sh"]
