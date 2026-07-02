FROM denoland/deno:bin@sha256:978d3d9d73452234f830739773a0a1a7e3b60463da3dfbcd99375e86ac5481e5 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:f1f52afcc7e0149d36b067da7280b08bef4b9f736e91b44764f69696b20a644b

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
