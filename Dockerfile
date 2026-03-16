FROM denoland/deno:bin@sha256:b0bc343ae5fabb4c1c1def9984f3c4834de86ccfc52f9b5f0ae10e8c06fdcfd2 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:a6843d764bad100d7afaa5e293a9f1ca141755ffba57665f966949c86f8b5f24

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
