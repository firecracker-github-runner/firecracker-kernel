FROM denoland/deno:bin@sha256:85c1a900e540037478d1d74e4a04aeae62de746d0bad5d3bf254e7c42d2c581e AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:285222f18947279596f7087fcf087372fc9c18b4e15836acb5e56328c9f28ea6

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
