FROM denoland/deno:bin@sha256:9b5384608a67d466c5d444e562e1717dab4d9fca0071af6c07392199764818ce AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:eea305050b90191fd8f50c158f63c12d9d9145755e3e33ca861096139275a6d3

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
