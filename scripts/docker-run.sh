#! /bin/bash

set -eux -o pipefail

function main {
  local extra_args="$@"

  mkdir -p ./dist
  mkdir -p ./working
  mkdir -p ./.deno-cache

  chmod a+w ./dist
  chmod a+w ./working
  chmod a+w ./.deno-cache

  docker run --rm \
    -v ./src:/working/src:ro \
    -v ./dist:/working/dist:rw \
    -v ./working:/working/working:rw \
    -v ./.deno-cache:/home/builder/.cache/deno:rw \
    $extra_args \
    firecracker-kernel-working
}

main "$@"
