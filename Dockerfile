FROM denoland/deno:bin@sha256:adb5c62f47bb014f8da2f2db5fe250ea895ad2ae2f02bcde0eda853f91d0ec31 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:5ea1d6bce413de7979d0e944d5a08e9bca9bebaf6f4882ca5191092c468b7d62

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
