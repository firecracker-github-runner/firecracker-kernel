FROM denoland/deno:bin@sha256:9f18d20207f2699595ea26d14e0b7e123cd0cd01100a577bc11f8ca5906c2d81 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:262632df11d0f01e89c0b90088ad15f4c5c27ff1526eb771541ff03de4d2db21

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
