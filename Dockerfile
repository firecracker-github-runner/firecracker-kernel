FROM denoland/deno:bin@sha256:1245e9856180be858aebeefdff2c3b98dc01e8ea667b48f4fb64647dc56bb61d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:75db5e2bef8165b6bd807d60383c6f0bb8b6be6b9aebcdd2335eb7f747e8cd1b

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
