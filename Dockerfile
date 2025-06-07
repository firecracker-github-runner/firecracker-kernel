FROM denoland/deno:bin@sha256:ba88ea675dc8979682cda71b26d2e3761e41378d9777f725ebc0488d4a64cd1f AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:df8b6a48ec2a6dc56e3c3b283e86236c6caf51bbc083dd60a18389e6c1ddd591

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
