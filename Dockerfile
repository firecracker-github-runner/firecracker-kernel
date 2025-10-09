FROM denoland/deno:bin@sha256:1245e9856180be858aebeefdff2c3b98dc01e8ea667b48f4fb64647dc56bb61d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:924e30cfaba9cc204e1e7397ebca5c350edca690e720202cf6c5f71f95f08f02

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
