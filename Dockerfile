FROM denoland/deno:bin@sha256:49ba8ba927b71c772b4f244206dc1045d35f41d502e13c6f7a053e09821a58ab AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:f2d869d42f6c787aacc8f62c510e90715915db01616d66122f2fb128f1ecdfff

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
