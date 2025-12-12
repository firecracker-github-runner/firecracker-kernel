FROM denoland/deno:bin@sha256:e76562c56fbcbda664e9ca7dce0a934496401fe78c0f64d03f76b9b62b3064b8 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:d14540c194bbbd14957369dcad77cd18542593418a58f10c7bc87950820c91d5

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
