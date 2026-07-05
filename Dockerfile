FROM denoland/deno:bin@sha256:978d3d9d73452234f830739773a0a1a7e3b60463da3dfbcd99375e86ac5481e5 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:92b72dd78df4e7ba91480ed836256833851ae8b8898c6363f314f2299ee805cf

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
