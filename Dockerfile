FROM denoland/deno:bin@sha256:10df98529ccf66287a5bd16e32cc91e4026b22af02d1207985f78bc9d9473157 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:5e60ac5dcfdae6cac0690cf88329098333721ebaa4b03ce49e144f01534c5436

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
