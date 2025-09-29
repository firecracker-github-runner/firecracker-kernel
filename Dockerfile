FROM denoland/deno:bin@sha256:b0e1bf78aea23abe03edf5c411cb9db3e1011d8659bfdeafcb80c1f53cdd71d7 AS deno

FROM ghcr.io/firecracker-github-runner/ubuntu-kernel-dev-image:main@sha256:8f79a0eb296a15d7cff05f2c87cfad42f24ad1dece59f925b22c4e5694249ac9

COPY --chown=root:0 --from=deno /deno /usr/bin/deno

COPY --chown=root:0 ./deno.jsonc ./deno.lock ./versions.yaml /working/

VOLUME /working/src
VOLUME /working/dist

CMD ["deno", "task", "build"]
