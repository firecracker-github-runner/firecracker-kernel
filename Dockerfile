FROM denoland/deno:bin@sha256:f679fecf34c1956fa88b93768788fbdb82549b75f301d5b10cdcc253c4f1aa3b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:88156bc9a881645d7fc57d510858f4db55ad8bd8268ed03848154023f12240e0

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
