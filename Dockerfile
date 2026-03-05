FROM denoland/deno:bin@sha256:e9fdc2ac029d1eb93c489bb72e34349df5b5586eddd2629b12b3216c973bd01d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:c3c9f736d63957cb9c372f1031dbee69f750d24c8f3702efd9a6431a4efbb866

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
