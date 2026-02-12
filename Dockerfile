FROM denoland/deno:bin@sha256:4e3c4ae12c77815f5872480df7bcd4f472b0badd38d84fe6eb9ec12df386dc0d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:d08e96c206e06372501800e59aa1a90d9a062fb2a2a2aa0a3c18e544d2339469

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
