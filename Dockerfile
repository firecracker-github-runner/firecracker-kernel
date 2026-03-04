FROM denoland/deno:bin@sha256:e9fdc2ac029d1eb93c489bb72e34349df5b5586eddd2629b12b3216c973bd01d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:28be25347d6f8c6ffc4f04a99cc046e21bb9d59780815f7f30507a73d8f4a441

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
