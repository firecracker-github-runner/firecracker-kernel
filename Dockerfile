FROM denoland/deno:bin@sha256:a947d7ea218d4b1cce3d17366d9ef2de96e20e0e54080025f5a8be70c9c020ee AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:b18cd7a0e4e5093dea469a170e87b32f0123d2e82f7ab0fe759d23b3f52c6a2a

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
