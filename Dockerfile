FROM denoland/deno:bin@sha256:fe932c131a8442571da017f3bf64aa650731cbbb128d9c9fc047fd0e0d53d8f9 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:d14540c194bbbd14957369dcad77cd18542593418a58f10c7bc87950820c91d5

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
