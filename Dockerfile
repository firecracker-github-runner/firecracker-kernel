FROM denoland/deno:bin@sha256:ba88ea675dc8979682cda71b26d2e3761e41378d9777f725ebc0488d4a64cd1f AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:82756e97dcf5d5dbf1b6279a8e9d3516c7ff5c3ca708e8a4de6aa28dab30ff13

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
