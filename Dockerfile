FROM denoland/deno:bin@sha256:4a0c035e554ee9961e40d2d20ff8ad05f273230c8a0290a7cbad214d5d26ab10 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:2269c03d42fe55df73ce9197a00f16ef5b17c4a593c15264525809814b6bbbc8

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
