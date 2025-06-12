FROM denoland/deno:bin@sha256:a0656524e2222d456cbb77ce93cb685020120fedb5932683122f88d64019a147 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:df8b6a48ec2a6dc56e3c3b283e86236c6caf51bbc083dd60a18389e6c1ddd591

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
