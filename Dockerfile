FROM denoland/deno:bin@sha256:aaac5acf43532012f1126f7fbcd0b174ccd51504e569cc6859a7d286a1e0e03e AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:fffb1570c2fffb9b8880449b4d7e8a4e678830a07fedca36252b784dde259d1a

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
