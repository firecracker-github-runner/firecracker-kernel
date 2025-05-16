FROM denoland/deno:bin@sha256:f08f318eb5dadaf6d2e4527c718bfd7161a501b1ca8468c20609c62c0eaecac0 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:285222f18947279596f7087fcf087372fc9c18b4e15836acb5e56328c9f28ea6

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
