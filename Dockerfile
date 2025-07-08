FROM denoland/deno:bin@sha256:3a6d4942dc78b199f9dd6db1915fc91b389140a3f48402139063f4d679e0a8e8 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:017de4a408f84fcf0977a3252bf9fecf0fe0f688a5213bcf387fb4ac962cd9af

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
