FROM denoland/deno:bin@sha256:9fc95c8d37fa63b60c22976436c924e2938cd9705e424a5e0e387bcc07f7ce06 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:bd71357ba4a3c83698a458afd65e5bde3305dc15081161921af02aa7e234032c

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
