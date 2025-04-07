FROM denoland/deno:bin@sha256:3d407108ff404a9d16a429ea61e4b301179c24773fb25470374894c000089d4e AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:61a352072711109cea1fa1eec97c3e215c67db145037cdd7010e3fb9e21c205e

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
