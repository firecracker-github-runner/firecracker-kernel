FROM denoland/deno:bin@sha256:2c4cc204a23f94843054077f8de4fe18e999eed29ee22f84b284dc7ee182a1bf AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:eea305050b90191fd8f50c158f63c12d9d9145755e3e33ca861096139275a6d3

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
