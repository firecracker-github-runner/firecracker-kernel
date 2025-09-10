FROM denoland/deno:bin@sha256:99d546b191fbf3e57d8a1b7eba3430ab22158bbbbfc132a91e590632047adc5d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:5cd1f854fd97ce1340df3a0dabcdb1018fed70752e74b1214998c2302e19fd94

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
