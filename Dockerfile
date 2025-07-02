FROM denoland/deno:bin@sha256:fb86b1cde9d9807f83f087150a4241abd4eb696ab979a7a8cf5b4d4c7cb0ac8b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:017de4a408f84fcf0977a3252bf9fecf0fe0f688a5213bcf387fb4ac962cd9af

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
