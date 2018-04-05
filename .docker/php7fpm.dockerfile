FROM alpine:3.7

ADD . /www

RUN \
    mkdir /run/php-fpm/; \
    apk update; \
    apk add \
        php7 \
        php7-openssl \
        php7-pdo \
        php7-cli \
        php7-mbstring \
        php7-tokenizer \
        php7-xml \
        php7-ctype \
        php7-json \
        php7-fpm \
        php7-pdo_mysql \
        php7-session; \
    adduser -D -g 'www' www; \
    chown -R www:www /var/lib/php7; \
    chown -R www:www /www;

ADD ./.docker/php7fpm_conf/z-www.conf /etc/php7/php-fpm.d/z-www.conf

ENTRYPOINT ["php-fpm7", "-O", "-F"]

EXPOSE 9000
