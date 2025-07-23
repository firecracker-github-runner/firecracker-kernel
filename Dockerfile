FROM denoland/deno:bin@sha256:f679fecf34c1956fa88b93768788fbdb82549b75f301d5b10cdcc253c4f1aa3b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:7b848c67f693e5dba27966df2d5e960fa8de3535caea02bc7c4e0bde4da194c2

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
