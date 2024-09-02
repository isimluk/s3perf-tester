FROM fedora:latest

RUN dnf install -y s3cmd diffutils \
 && dnf clean all

ADD entrypoint.sh /

ENTRYPOINT /entrypoint.sh
