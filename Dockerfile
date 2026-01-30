FROM denoland/deno:bin@sha256:10df98529ccf66287a5bd16e32cc91e4026b22af02d1207985f78bc9d9473157 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:1552a9ad47689a4df4a66ede7f186df24f103f3f1ef133c16c53cf0e43c1f9cc

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
