FROM php:7.1

MAINTAINER Uwe Kleinmann <u.kleinmann@kellerkinder.de>

RUN apt-get update -yqq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    libpq-dev \
    openssh-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmagickwand-6.q16-dev \
    imagemagick-6.q16 \
    libmcrypt-dev \
    libpng12-dev \
    libssl-dev \
    libxml2-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN pecl install imagick && \
    docker-php-ext-enable imagick && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install pdo_pgsql && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install soap

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
