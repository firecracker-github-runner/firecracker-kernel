FROM denoland/deno:bin@sha256:f304c8cefe494191d371b4df9ee8193f210cf0d28e7d62668e1088661c88cba2 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:9313dc152d5f13e52deb40eb8356fa2cf7e5ea2725f8c72af66f3f6bfa394f80

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
