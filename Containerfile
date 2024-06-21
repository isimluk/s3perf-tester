FROM fedora:latest

RUN dnf install -y s3cmd \
 && dnf clean all

ADD entrypoint.sh /

ENTRYPOINT /entrypoint.sh
