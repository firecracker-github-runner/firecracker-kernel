FROM denoland/deno:bin@sha256:9ac6b95faa289ad20ba55e51c9a09fcd96fa8b65365f460ec2880b6c9e2a4e86 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:8c4a5350e72e4d1abb36fea1def69ed6082aae11f284aaf5ee15bc5a8c9a865a

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
