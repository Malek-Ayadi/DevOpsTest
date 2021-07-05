FROM php:7.1-fpm

ENV DOCKER_IMAGE php-fpm
ENV DOCKER_NAME php-fpm
ENV TZ Europe/Vienna

### Remove default php-fpm configs

RUN set -x && \
  rm -rf /usr/local/etc/php-fpm.d

### Install our default php extensions

RUN set -x && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
        apt-transport-https ca-certificates && \
    apt-get install -y \
        libmcrypt-dev \
        default-mysql-client && \
    docker-php-ext-install -j$(nproc) \
        bcmath && \
    curl -sS -o /usr/local/bin/composer https://getcomposer.org/composer-1.phar && \
    chmod +x /usr/local/bin/composer && \
    ## add mcrypt
    pecl install mcrypt-1.0.0 && \
    # enable mcrypt by default
    docker-php-ext-enable mcrypt && \
    # tiny helper to reload php config
    printf '#!/bin/bash\nkill -s USR2 `pidof php-fpm`\n' >> /usr/local/bin/php-reload && \
    chmod +x /usr/local/bin/php-reload && \
    # Force umask 002 for php-fpm
    sed -i '/exec.*/ i umask 002' /usr/local/bin/docker-php-entrypoint && \
    # Create compose cache directory
    /usr/bin/install -m 0777 -o www-data -g www-data -d /var/www/.composer && \
    # Cleanup
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/www/.composer

ENV COMPOSER_CACHE_DIR=/var/www/.composer

#terminal size
ENV COLUMNS="`tput cols`"
ENV LINES="`tput lines`"

COPY ./conf /usr/local/etc/

## env php.ini
ENV PHP_MEMORY_LIMIT "2G"
ENV PHP_MAX_EXECUTION_TIME "30"
ENV PHP_DATE_TIMEZONE "Europe/Vienna"
ENV PHP_UPLOAD_MAX_FILESIZE "20M"
ENV PHP_POST_MAX_SIZE "20M"
ENV PHP_ERROR_REPORTING "E_ALL & ~E_DEPRECATED & ~E_STRICT"
ENV PHP_DISPLAY_STARTUP_ERRORS "Off"

## opcache settings
ENV OPCACHE_ENABLE 1
ENV OPCACHE_ENABLE_CLI 0
ENV OPCACHE_MEMORY_CONSUMPTION 512
ENV OPCACHE_MAX_ACCELERATED_FILES 100000
ENV OPCACHE_VALIDATE_TIMESTAMPS 1
ENV OPCACHE_CONSISTENCY_CHECKS 0

## env php-fpm.ini
RUN mkdir -p /var/log/php/;
RUN chmod -R o+w /var/log/php;

ENV PHP_FPM_LOG_ERRORS 1
# ENV PHP_FPM_DISPLAY_ERRORS 1 # must be empty to have them off, 0 does not work!
ENV PHP_FPM_PORT 9000
ENV PHP_FPM_ACCESS_LOG="/var/log/php/fpm-access.log"
ENV PHP_FPM_ERROR_LOG="/proc/self/fd/2"
ENV PHP_FPM_PM dynamic
ENV PHP_FPM_PM_MAX_CHILDREN 50
ENV PHP_FPM_PM_START_SERVERS 10
ENV PHP_FPM_PM_MAX_SPARE_SERVERS 20
ENV PHP_FPM_PM_MIN_SPARE_SERVERS 5
ENV PHP_FPM_CATCH_WORKERS_OUTPUT 1

# add user loop user
ENV BUILD_USER=1000
RUN useradd -d /home/loop -m -u $BUILD_USER -g www-data loop
