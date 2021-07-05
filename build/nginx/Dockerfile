FROM nginx:1.16

ENV DOCKER_IMAGE nginx
ENV DOCKER_NAME nginx
ENV TZ Europe/Vienna

RUN set -x && \
    # tiny helper to reload nginx config
    printf '#!/bin/bash\n/usr/sbin/nginx -s reload\n' >> /usr/local/bin/nginx-reload && \
    chmod +x /usr/local/bin/nginx-reload && \
    # delete nginx default server config
    rm /etc/nginx/conf.d/default.conf

COPY ./conf/ /etc/

ENV WORKER_PROCESSES auto
ENV WORKER_CONNECTIONS 1024

ENV SERVER_NAME localhost
