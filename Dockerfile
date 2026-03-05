FROM denoland/deno:bin@sha256:e9fdc2ac029d1eb93c489bb72e34349df5b5586eddd2629b12b3216c973bd01d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:033491601902bee79b98a42dab0c37291dc0004f5039c4a4df2e2bc982c23e69

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
