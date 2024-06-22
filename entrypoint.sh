#!/bin/bash

set -euo pipefail -x

nonse=$(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 13; echo)

cat <<EOF > "${HOME}/.s3cfg"
[default]
access_key = ${ACCESS_KEY}
host_base = ${HOST}
host_bucket = ${HOST}/%(bucket)
secret_key = ${SECRET_KEY}
EOF

# Verify Set-up Authentication
s3cmd -d -v la --stats s3://${BUCKET}

test_file=/tmp/testfile.txt
dd if=/dev/urandom of=${test_file} bs=1024 count=${FILE_SIZE_KB:-8192}

while true; do
    remote_filename=$(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 4; echo)
    s3cmd put --stats ${test_file} s3://${BUCKET}/deletable-perf-test/${nonse}/${remote_filename}
    s3cmd rm --stats --force s3://${BUCKET}/deletable-perf-test/${nonse}/${remote_filename}
done
