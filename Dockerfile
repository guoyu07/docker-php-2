FROM php:7.1.2-fpm

MAINTAINER hteen <i@hteen.cn>

# Install modules
RUN apt-get update && apt-get install -y \
        git \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        --no-install-recommends && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN git clone https://github.com/laruence/yaf.git /usr/src/php/ext/yaf/
RUN git clone https://github.com/laruence/yar.git /usr/src/php/ext/yar/
RUN git clone https://github.com/laruence/yaconf.git /usr/src/php/ext/yaconf/
RUN git clone -b php7 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis/
RUN git clone https://github.com/swoole/swoole-src.git /usr/src/php/ext/swoole/
    
RUN docker-php-ext-install -j$(nproc) pdo_mysql mysqli mbstring opcache yaf yar yaconf redis swoole