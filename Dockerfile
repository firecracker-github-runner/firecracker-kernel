FROM denoland/deno:bin@sha256:892c168f8df9731133f76715f31ef01d502915a65e16f052f0c51ab187d474cb AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:9e9321a91e4a67afd6317c2030db2c09ea0c53564cc21007ff927c495afb0ae8

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
