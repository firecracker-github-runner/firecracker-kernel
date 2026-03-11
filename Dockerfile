FROM denoland/deno:bin@sha256:b0bc343ae5fabb4c1c1def9984f3c4834de86ccfc52f9b5f0ae10e8c06fdcfd2 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:af87ab05c8996a1e7e2e26b1ca1f83a99fc56f19ea084ce11380e521fb019dd6

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
