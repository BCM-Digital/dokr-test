# Stage 1.
# Build the application framework and cache where applicable.
FROM tristanpixls/enzyme-build:php-laravel as build
COPY . /src
WORKDIR /src
RUN composer install
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

# Stage 2.
# Build all staticly served files.
FROM kkarczmarczyk/node-yarn:8.0 as static
COPY . /src
WORKDIR /src
RUN yarn --production

# Final stage.
# Build the final high-performance web server.
FROM tristanpixls/enzyme-deploy:php-laravel
COPY --from=build /src/vendor /src/vendor
COPY --from=build /src/bootstrap /src/bootstrap
COPY --from=static /src/public /src/public
COPY --from=build /src/storage /src/storage
COPY ./app /src/app
COPY ./database /src/database
COPY ./.env /src/.env
