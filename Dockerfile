FROM denoland/deno:bin@sha256:f679fecf34c1956fa88b93768788fbdb82549b75f301d5b10cdcc253c4f1aa3b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:9584114de67b5156d3a7b81ca039d173ba0233338c75e3451cfc60467cd31a0c

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
