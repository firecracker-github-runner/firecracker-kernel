FROM denoland/deno:bin@sha256:a479d91f958895f3b9804ab4dd074b596a497fe0d4af198bfd2f688e61297c39 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:92b72dd78df4e7ba91480ed836256833851ae8b8898c6363f314f2299ee805cf

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
