FROM denoland/deno:bin@sha256:10df98529ccf66287a5bd16e32cc91e4026b22af02d1207985f78bc9d9473157 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:262632df11d0f01e89c0b90088ad15f4c5c27ff1526eb771541ff03de4d2db21

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
