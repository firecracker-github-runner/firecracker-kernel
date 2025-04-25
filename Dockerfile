FROM denoland/deno:bin@sha256:1d45ada83f831960169f2df5531eee0204e96657c4a926c37fd875f79ceb0ffa AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:0ee88c95e11d646ecb059ed4a280c71e3c0874e849cee6b7310d3699bc931803

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
