FROM denoland/deno:bin@sha256:25675bd2a125b59bdcfbb6592ec5c332a2bc56e0dabf038184d8b2c6aec45c3b AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:8ab8987ba3cb082d10f592cff95e35f624c695b2cdf0e5123618932e179df3ca

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
