FROM php:7.4-fpm

WORKDIR /var/www/html/

RUN set -ex; \
    \
    apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libzip-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j "$(nproc)" gd exif imagick intl \
    mysqli \
    pdo \
    pdo_mysql \
    zip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ARG UNAME=www-data
ARG UGROUP=www-data
ARG UID=1000
ARG GID=1000
RUN usermod -u $UID $UNAME && groupmod -g $GID $UGROUP
# RUN set -x \
#     && set -e \
#     && mkdir -p /var/www/html/ \
#     && chown -R root:www-data /var/www/

# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# CMD bash -c "composer install && php-fpm"
# CMD bash -c "php-fpm"

RUN ls -la
