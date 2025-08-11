FROM denoland/deno:bin@sha256:d24076d8c8d058d7b822cc7ef7e2c95d0912bfc56e376183c26d46ff80309175 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:cfae42af73710b96181895753696862f6bb97d834966a225f8af763d345d42a0

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
