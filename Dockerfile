FROM denoland/deno:bin@sha256:3a6d4942dc78b199f9dd6db1915fc91b389140a3f48402139063f4d679e0a8e8 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:9584114de67b5156d3a7b81ca039d173ba0233338c75e3451cfc60467cd31a0c

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
