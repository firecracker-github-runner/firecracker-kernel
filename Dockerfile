FROM denoland/deno:bin@sha256:2f5f9d651af33c337767c423a340f76df35e35ff8ff4734210237b9c6fed94c7 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:ba7881ab4dd1c239b08a9c6a3453db5ea8ba1dd8e4ef34cc7b7c2384be538fd0

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
