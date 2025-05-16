FROM denoland/deno:bin@sha256:2e9dabeaed7c91d58ef7f9b4996a8d15642b78854beda2831d4e7e55d1336da4 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:285222f18947279596f7087fcf087372fc9c18b4e15836acb5e56328c9f28ea6

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
