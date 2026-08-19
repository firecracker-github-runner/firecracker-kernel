FROM denoland/deno:bin@sha256:0d1262facd139e815217c001945eb822c7a78584cf660142c34a6b53effec1aa AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:3d5526afe2c7ba224198b33364509a5d16fc325ffb3fa52d19738cf47a671133

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
