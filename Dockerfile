FROM denoland/deno:bin@sha256:754be20b2f6342dc2ad21f2d620b586b632eeb2f5af1387100c042089be5118c AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:f1f52afcc7e0149d36b067da7280b08bef4b9f736e91b44764f69696b20a644b

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
