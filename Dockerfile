FROM denoland/deno:bin@sha256:fe932c131a8442571da017f3bf64aa650731cbbb128d9c9fc047fd0e0d53d8f9 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:c999cd30c5cf6dbfd0d1575418cb0b9db35f8418c3e49dcd606609afb10598c7

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
