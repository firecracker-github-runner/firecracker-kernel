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
    unzip \
    xz \
    yasm && \
    dnf clean all

RUN useradd builder -G 0 && \
    mkdir -p /working && \
    chown -R builder:0 /working

WORKDIR /working

USER builder
RUN curl -fsSL https://deno.land/x/install/install.sh | sh
USER root
RUN ln -s /home/builder/.deno/bin/deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml  ./

USER builder

VOLUME /home/builder/.cache/deno
VOLUME /working/src
VOLUME /working/dist
VOLUME /working/working

CMD ["deno", "task", "build"]
