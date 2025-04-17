FROM denoland/deno:bin@sha256:046ba0fbeeda9d94e42a4c6f8178b0f19f5ec8b4952c9a6c090dfc14d176ba66 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:fa0b1e20691db2ba834b6a0cd942b42d9837f4f3531db6e387e8baa0bf41f7bb

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
