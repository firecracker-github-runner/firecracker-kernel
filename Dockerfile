FROM denoland/deno:bin@sha256:892c168f8df9731133f76715f31ef01d502915a65e16f052f0c51ab187d474cb AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:4c1d018e908f0905bd4c06a8f950a77ef6bb1f9f2d1fc9fd06e384f137cd0c42

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
