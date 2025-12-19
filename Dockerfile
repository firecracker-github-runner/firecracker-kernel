FROM denoland/deno:bin@sha256:b8d1960fa839d1cfd044e14c2f4709324e600cf59b54c25c04cfde77044451b1 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:c999cd30c5cf6dbfd0d1575418cb0b9db35f8418c3e49dcd606609afb10598c7

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
