#! /bin/bash

set -eux -o pipefail

mkdir -p ./dist
mkdir -p ./working
docker run -it --rm \
  -v ./src:/working/src:ro \
  -v ./dist:/working/dist:rw \
  -v ./working:/working/working:rw \
  -v ./.deno-cache:/home/builder/.cache/deno:rw \
  firecracker-kernel-working
