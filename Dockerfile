FROM denoland/deno:bin@sha256:fb86b1cde9d9807f83f087150a4241abd4eb696ab979a7a8cf5b4d4c7cb0ac8b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:bd71357ba4a3c83698a458afd65e5bde3305dc15081161921af02aa7e234032c

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
