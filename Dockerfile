FROM tristanpixls/enzyme-deploy:php-laravel

COPY ./vendor /src/vendor
COPY ./bootstrap /src/bootstrap
COPY ./public /src/public
COPY ./storage /src/storage
COPY ./app /src/app
COPY ./database /src/database
COPY ./.env /src/.env
