FROM denoland/deno:bin@sha256:9ac6b95faa289ad20ba55e51c9a09fcd96fa8b65365f460ec2880b6c9e2a4e86 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:60de41ec8e2ceed170b276b03e3b6377272f5318a841fc8ac57d8a0800e34831

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
