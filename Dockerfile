FROM php:8.0.8-fpm-alpine3.14
RUN docker-php-ext-install pdo pdo_mysql