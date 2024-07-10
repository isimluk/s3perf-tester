#!/usr/bin/env sh

set -euo pipefail

podman build -t s3perf-tester .

podman run -it \
    -e ACCESS_KEY \
    -e SECRET_KEY \
    -e HOST \
    -e BUCKET \
    -e FILE_SIZE_KB \
    -e SKIP_SSL_CHECK \
    ${PODMAN_EXTRA_ARGS} \
    --rm s3perf-tester
