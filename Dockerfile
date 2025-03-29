FROM denoland/deno:bin@sha256:e6dbea555ae97b51f206c77f5d9fbfec3965976f9658145c7bc2f9303bdc87c3 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:741b71b81fff88c8f6337ba1d9d110e9e14c26898fe6cb51eb5da1294f136b84

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml ./LICENSE /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
