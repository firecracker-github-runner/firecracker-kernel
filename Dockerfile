FROM denoland/deno:bin@sha256:892c168f8df9731133f76715f31ef01d502915a65e16f052f0c51ab187d474cb AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:0651fc25c2f0cf58c6137ac62b00d62f17a4397459f4f899e8eba48c6c560278

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
