FROM denoland/deno:bin@sha256:764a91cef86118b822ce1770c512bf1ea2a73fd5af4a504fdb915dfe2fd9e15b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:1b6f486bdec83127ad16c569f83b9ab2dbc626774186ffa186a8d363c0001d97

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
