FROM denoland/deno:bin@sha256:a947d7ea218d4b1cce3d17366d9ef2de96e20e0e54080025f5a8be70c9c020ee AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:d08e96c206e06372501800e59aa1a90d9a062fb2a2a2aa0a3c18e544d2339469

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
