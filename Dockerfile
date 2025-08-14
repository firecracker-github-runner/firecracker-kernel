FROM denoland/deno:bin@sha256:de280de26daca8ed578dcea456826f7fb30bf8fe5e33c9bbc5c22f2eace633b4 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:2269c03d42fe55df73ce9197a00f16ef5b17c4a593c15264525809814b6bbbc8

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
