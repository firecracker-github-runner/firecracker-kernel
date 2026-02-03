FROM denoland/deno:bin@sha256:7923bc3a7b687877a76fc8414f0313a2f15627c010bdf932ab33977a2a4c0fa6 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:5b7f91efdf93b9afd9313a81d56195bc89403aee689c9de4fc8be9facec95ebe

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
