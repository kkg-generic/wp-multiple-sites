FROM php:7.4-fpm

RUN set -ex; \
    usermod -u 1000 www-data;

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
    && docker-php-ext-install -j "$(nproc)" gd \
    mysqli \
    pdo \
    pdo_mysql \
    zip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# CMD bash -c "composer install && php-fpm"
# CMD bash -c "php-fpm"

RUN ls -la
