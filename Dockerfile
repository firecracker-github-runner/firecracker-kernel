FROM denoland/deno:bin@sha256:aaac5acf43532012f1126f7fbcd0b174ccd51504e569cc6859a7d286a1e0e03e AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:f1f52afcc7e0149d36b067da7280b08bef4b9f736e91b44764f69696b20a644b

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
