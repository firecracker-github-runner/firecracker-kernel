FROM denoland/deno:bin@sha256:1245e9856180be858aebeefdff2c3b98dc01e8ea667b48f4fb64647dc56bb61d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:a189a2fd6e97e61187a3280da448bda9c1cb7587bdc52837c506b7409591a1f2

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
