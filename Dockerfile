FROM denoland/deno:bin@sha256:3d407108ff404a9d16a429ea61e4b301179c24773fb25470374894c000089d4e AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:e80801c09b04cd3f48ee53e8ba32d6c41f8e46e3cba1cec71a75d1680597c7fe

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
