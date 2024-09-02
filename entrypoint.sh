#!/bin/bash

set -euo pipefail -x

nonse=$(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 13; echo)

cat <<EOF > "${HOME}/.s3cfg"
[default]
access_key = ${ACCESS_KEY}
secret_key = ${SECRET_KEY}
EOF

if [ -n "${HOST}" ]; then
    echo "host_base = ${HOST}" >> "${HOME}/.s3cfg"
    echo "host_bucket = ${HOST}/%(bucket)" >> "${HOME}/.s3cfg"
    if [ "${SKIP_SSL_CHECK:-)}" == insecure ]; then
        echo "check_ssl_certificate = False" >> "${HOME}/.s3cfg"
    fi
else
    echo "bucket_location = ${REGION:-us-east-1}" >> ${HOME}/.s3cfg
fi

# Verify Set-up Authentication
s3cmd -d -v la --stats s3://${BUCKET}

test_file=/tmp/testfile.txt
dd if=/dev/urandom of=${test_file} bs=1024 count=${FILE_SIZE_KB:-8192}

test_runner() {
    while true; do
        remote_filename=$(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 4; echo)
        remote_url="s3://${BUCKET}/deletable-perf-test/${nonse}/${remote_filename}"
        s3cmd put --stats ${test_file} "${remote_url}"

        tmp_file=$(mktemp)
        s3cmd get --stats "${remote_url}" "${tmp_file}"
        diff ${test_file} "${tmp_file}"
        rm "${tmp_file}"

        s3cmd rm --stats --force "${remote_url}"
    done
}

for _i in $(seq "${PROCESSES:-1}"); do
     test_runner &
done

wait
