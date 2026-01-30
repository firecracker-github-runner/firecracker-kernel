FROM denoland/deno:bin@sha256:10df98529ccf66287a5bd16e32cc91e4026b22af02d1207985f78bc9d9473157 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:3d5a5accecbacca876a97aac9d1c90c1b063f47ee34788112e518dcf6581548e

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
