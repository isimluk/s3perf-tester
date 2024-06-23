FROM ubuntu:latest

RUN apt-get update -y \
    && apt-get install -y s3cmd \
    && apt-get clean \
    && rm -f /var/lib/apt/lists/*_*

ADD entrypoint.sh /

ENTRYPOINT /entrypoint.sh
