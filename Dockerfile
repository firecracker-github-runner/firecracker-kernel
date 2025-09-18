FROM denoland/deno:bin@sha256:49ba8ba927b71c772b4f244206dc1045d35f41d502e13c6f7a053e09821a58ab AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:59cd59c1bc0b04561738d27a5ac2d393de82bd3063eda4f617cac5879d9bfa7f

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
