FROM denoland/deno:bin@sha256:2f5f9d651af33c337767c423a340f76df35e35ff8ff4734210237b9c6fed94c7 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:fc4d9399393cf2aa916df2dae8ddcc46c4eb3004bb773df53548001d4a2972dd

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
