FROM denoland/deno:bin@sha256:58cb564dc6576388a2e55b50c4a3d53a374276fb6f2f5eb759b9a4825234aecd AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:741b71b81fff88c8f6337ba1d9d110e9e14c26898fe6cb51eb5da1294f136b84

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
