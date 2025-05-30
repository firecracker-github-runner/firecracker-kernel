FROM denoland/deno:bin@sha256:ba88ea675dc8979682cda71b26d2e3761e41378d9777f725ebc0488d4a64cd1f AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:351d9b7c8be4bfd922ba6da5b51f86a386a28a5e2e4fd7695b20027c66c5a667

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
