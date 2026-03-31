FROM denoland/deno:bin@sha256:6dd27a6c41ae66edf209e2f9981278b4f3510b9f6c0cdc1fd4511e08a7ec567d AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:a6843d764bad100d7afaa5e293a9f1ca141755ffba57665f966949c86f8b5f24

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
