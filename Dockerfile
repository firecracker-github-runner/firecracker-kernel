FROM denoland/deno:bin@sha256:9fc95c8d37fa63b60c22976436c924e2938cd9705e424a5e0e387bcc07f7ce06 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:8da798a26b4cb0ef6611097d2bc13bf68887998c22ad418724da7b38d49de769

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
