FROM mysql:8

ENV DOCKER_IMAGE mysql
ENV DOCKER_NAME mysql
ENV TZ Europe/Vienna

USER root

COPY ./backup.sh /usr/local/bin/backup

VOLUME /backup/

USER 1001
CMD ["mysqld", "--default-authentication-plugin=mysql_native_password", "--log-bin-trust-function-creators=1"]