FROM denoland/deno:bin@sha256:ec88939ec32f71398be6c83ce20a94bb85750428a2f47dc305fd7fd1f6b363d4 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:eed5296dd13035446ff33b13085e51ece0406888ccf1dca5b60e5668a83a13a7

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
