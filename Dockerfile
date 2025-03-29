FROM denoland/deno:bin@sha256:e6dbea555ae97b51f206c77f5d9fbfec3965976f9658145c7bc2f9303bdc87c3 AS deno

FROM ubuntu:noble@sha256:3afff29dffbc200d202546dc6c4f614edc3b109691e7ab4aa23d02b42ba86790

RUN apt update \
    && apt install -y \
    build-essential \
    libelf-dev \
    xz-utils \
    \
    # see: https://docs.kernel.org/process/changes.html#current-minimal-requirements
    bc \
    bindgen \
    bison \
    btrfs-progs \
    clang \
    curl \
    flex \
    gawk \
    # grub2-common \
    global \
    iptables \
    jfsutils \
    libssl-dev \
    # mcelog \
    # mkimage \
    # nfs-utils \
    make \
    pahole \
    # pcmciautils \
    # ppp \
    # quota-tools \
    reiserfsprogs \
    squashfs-tools \
    udev \
    xfsprogs \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

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
