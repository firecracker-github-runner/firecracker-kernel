FROM denoland/deno:bin@sha256:61d9e9c5284d87b0efd2509905b130c77ba0d5224f30df10ab70c03e9174c208 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:349ef065f35ab9b7e22e2877695a140402d3fcd7b3e49fc97f5deda7bd62bfc2

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
