FROM alpine:3.7

ADD ./public /www/public

RUN \
    mkdir /run/nginx/; \
    apk update; \
    apk add nginx; \
    adduser -D -g 'www' www; \
    chown -R www:www /var/lib/nginx; \
    chown -R www:www /www;

ADD ./.docker/nginx_conf/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]

EXPOSE 80
