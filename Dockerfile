FROM denoland/deno:bin@sha256:adb5c62f47bb014f8da2f2db5fe250ea895ad2ae2f02bcde0eda853f91d0ec31 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:806355b67eb2879fd24f69fd5375ef7a76c8bfba0a738ada0c7fde7ca7819487

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
