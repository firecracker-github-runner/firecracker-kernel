FROM denoland/deno:bin@sha256:6da792238fa246d07e7a4f4ade1ffe43bd8b72a0a7bebb5bc91d437734fd9d42 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:40bd225f69833e7aae847d61ba3909d146d17b939abd31e0732a67b46316d69a

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
