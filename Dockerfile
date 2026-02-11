FROM denoland/deno:bin@sha256:4e3c4ae12c77815f5872480df7bcd4f472b0badd38d84fe6eb9ec12df386dc0d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:ea2c3606b4732335815e5de5827c38d65c5c0c5b16fc0e35875b2a577ab002a9

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
