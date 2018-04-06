# Build the framework (Laravel, PHP, etc.)
FROM tristanpixls/enzyme-build:php-laravel as build
COPY . /src
WORKDIR /src
RUN composer install
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

# Build the static files (JS, Images, etc.)
FROM kkarczmarczyk/node-yarn:8.0 as static
COPY . /src
WORKDIR /src
RUN yarn --production

# Build the final high-performance web server.
FROM alpine:3.7
COPY --from=build /src/vendor /src/vendor
COPY --from=static /src/public /src/public
COPY ./app /src/app
COPY ./bootstrap /src/bootstrap
COPY ./storage /src/storage
COPY ./database /src/database
COPY ./.env /src/.env
