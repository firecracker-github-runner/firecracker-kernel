FROM denoland/deno:bin@sha256:2f5f9d651af33c337767c423a340f76df35e35ff8ff4734210237b9c6fed94c7 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:1ad1226dd5253210017e0e503e03cb205d32089f0ecd17a76a1ca64437bf4588

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
