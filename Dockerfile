FROM denoland/deno:bin@sha256:b0e1bf78aea23abe03edf5c411cb9db3e1011d8659bfdeafcb80c1f53cdd71d7 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:59cd59c1bc0b04561738d27a5ac2d393de82bd3063eda4f617cac5879d9bfa7f

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
