FROM denoland/deno:bin@sha256:eb93e70bd53efec4be113d9974107840756551bc1a59a8258892d7bbe5fb4ab0 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:296357981c46a8ba8217b607ecb844cf580e52507ecf9062733b646113f4673e

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
