FROM denoland/deno:bin@sha256:85c1a900e540037478d1d74e4a04aeae62de746d0bad5d3bf254e7c42d2c581e AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:b6ec279cbd3ef9f041648cba148a1c79c987d22fbae245c6db65078d3f6a55d6

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
