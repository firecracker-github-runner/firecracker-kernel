FROM denoland/deno:bin@sha256:6729b74ad32fa4e6e6081a7b95f3129cf3da98fc7ff8dcfe9682367ec556ec58 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:fa0b1e20691db2ba834b6a0cd942b42d9837f4f3531db6e387e8baa0bf41f7bb

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
