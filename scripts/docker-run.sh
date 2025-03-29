#! /bin/bash

set -eux -o pipefail

function main {
  local extra_args="$@"

  mkdir -p ./dist
  mkdir -p ./working

  chmod a+w ./dist
  chmod a+w ./working

  docker run -it --rm \
    -v ./src:/working/src:ro \
    -v ./dist:/working/dist:rw \
    -v ./working:/working/working:rw \
    -v ./.deno-cache:/home/builder/.cache/deno:rw \
    $extra_args \
    firecracker-kernel-working
}

main "$@"
