FROM denoland/deno:bin@sha256:adb5c62f47bb014f8da2f2db5fe250ea895ad2ae2f02bcde0eda853f91d0ec31 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:da27a7a17503d917c3d8fa78a8e3079f91c220b26b149eb8f88613c868f3d6e3

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
