ARG PHP_VERSION
ARG PHP_ENV
ARG PHP_MODE
FROM php:${PHP_VERSION}-${PHP_MODE}-alpine3.16 as build

RUN apk update && \
    apk upgrade --update-cache --available && \
    apk add --no-cache bash shadow git && \
    usermod -u 1000 www-data && groupmod -g 1000 www-data && \
    apk del shadow

ARG IPE_VERSION
RUN curl -sSLf -o /usr/local/bin/install-php-extensions \
            https://github.com/mlocati/docker-php-extension-installer/releases/download/${IPE_VERSION}/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions

ARG COMPOSER_VERSION
ARG REDIS_VERSION
RUN install-php-extensions \
        @composer-${COMPOSER_VERSION} \
        igbinary redis-${REDIS_VERSION} \
        intl xsl zip-stable yaml \
        pdo-stable pdo_pgsql-stable \
        pcntl ffi \
        sockets-stable ev-stable event-stable

RUN mkdir /etc/periodic/1min \
    && echo "*       *       *       *       *       run-parts /etc/periodic/1min" >> /etc/crontabs/root

WORKDIR /var/www

#env
FROM build as dev-env

ARG XDEBUG_VERSION
RUN install-php-extensions xdebug-${XDEBUG_VERSION}

ARG PHPSTAN_VERSION
RUN cd /opt && composer require phpstan/phpstan:$PHPSTAN_VERSION

ENV PATH "$PATH:/opt/vendor/bin"

COPY environments/dev.ini "$PHP_INI_DIR/conf.d/00-development.ini"

EXPOSE 9003

FROM build as prod-env

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    install-php-extensions opcache

# mode
FROM ${PHP_ENV}-env as fpm-mode
EXPOSE 9000
CMD bash -c "crond && php-fpm"

FROM ${PHP_ENV}-env as cli-mode
CMD ["php", "-a"]

FROM ${PHP_ENV}-env as zts-mode
CMD ["php", "-a"]

# final
FROM ${PHP_MODE}-mode
