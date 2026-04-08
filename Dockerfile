FROM denoland/deno:bin@sha256:adb5c62f47bb014f8da2f2db5fe250ea895ad2ae2f02bcde0eda853f91d0ec31 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:974abcacb6a2af9b30cf938b8b7b3b231f895affc07259356faec24013053577

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
