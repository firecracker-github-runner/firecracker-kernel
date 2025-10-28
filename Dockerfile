FROM denoland/deno:bin@sha256:a8dd9a073b2b4d1beb77a8174830c5af54e32517808dcc28249ed6c04fdac979 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:e143b3220eb0a28031744b3c89dffe4266e8fc733f7e60088cb705b8dd1ec367

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
