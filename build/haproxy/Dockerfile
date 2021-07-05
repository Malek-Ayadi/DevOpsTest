FROM haproxy:1.8

ENV DOCKER_IMAGE haproxy
ENV DOCKER_NAME loadbalancer
ENV TZ Europe/Vienna

ENV DOMAINS="local.loop"
#terminal size
ENV COLUMNS="`tput cols`"
ENV LINES="`tput lines`"

ENV HTTP_BIND_OPTS=""
ENV HTTPS_BIND_OPTS=""

USER root

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends rsyslog socat && \
    # setup files for haproxy logging
    touch /var/log/haproxy.log &&  \
    ln -sf /dev/stdout /var/log/haproxy.log && \
    # tiny helper to reload haproxy config
    printf '#!/bin/bash\nkill -s USR2 `pidof haproxy`\n' >> /usr/local/bin/haproxy-reload && \
    chmod +x /usr/local/bin/haproxy-reload && \
    # Cleanup
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/*

COPY ./etc/ /etc/

VOLUME /var/lib/certs

WORKDIR /etc

EXPOSE 80
EXPOSE 443

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
