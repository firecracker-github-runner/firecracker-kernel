FROM denoland/deno:bin@sha256:6b9f51ddd4f084d4e1e40fa093a87eb81edd1c14c8161c44981846b726c5e444 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:af87ab05c8996a1e7e2e26b1ca1f83a99fc56f19ea084ce11380e521fb019dd6

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
