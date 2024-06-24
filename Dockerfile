FROM fedora:32

RUN dnf install -y s3cmd \
 && dnf clean all

ADD entrypoint.sh /

ENTRYPOINT /entrypoint.sh
