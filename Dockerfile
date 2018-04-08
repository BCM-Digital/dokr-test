FROM tristanpixls/enzyme-deploy:php-laravel

MAINTAINER Tristan Strathearn <tristan@pixls.com.au>

COPY ./vendor /src/vendor
COPY ./bootstrap /src/bootstrap
COPY ./public /src/public
COPY ./storage /src/storage
COPY ./app /src/app
COPY ./database /src/database
COPY ./routes /src/routes
COPY ./config /src/config
COPY ./resources/views /src/resources/views
COPY ./resources/lang/* /src/resources/lang/*
COPY ./.env /src/.env

COPY ./artisan /src/artisan
WORKDIR /src
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

RUN rm -rf /src/routes /src/config artisan
