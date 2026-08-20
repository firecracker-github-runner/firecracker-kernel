FROM denoland/deno:bin@sha256:0d1262facd139e815217c001945eb822c7a78584cf660142c34a6b53effec1aa AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:8b8f71c6ed05e1cd788e2d925fe4f25134c6ec3717c61c8d07d6a6c364019704

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
