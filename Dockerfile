FROM denoland/deno:bin@sha256:4c99106eadea6645640dacf35967c97ae34814d54fc417f4f9e9746245e8633f AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:eed5296dd13035446ff33b13085e51ece0406888ccf1dca5b60e5668a83a13a7

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
