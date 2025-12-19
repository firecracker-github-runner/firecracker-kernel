FROM denoland/deno:bin@sha256:b8d1960fa839d1cfd044e14c2f4709324e600cf59b54c25c04cfde77044451b1 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:d14540c194bbbd14957369dcad77cd18542593418a58f10c7bc87950820c91d5

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
