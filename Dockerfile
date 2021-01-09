FROM php:8.0-fpm-buster

#更换源
RUN    sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list 

#编译安装核心扩展 gd
RUN apt-get update &&\
    apt-get install -y     libfreetype6-dev libjpeg62-turbo-dev libpng-dev &&\
    docker-php-ext-configure gd --with-freetype --with-jpeg &&\
    docker-php-ext-install -j$(nproc) gd

#pecl 安装扩展 redis
RUN pecl install redis-5.3.2 \
    && docker-php-ext-enable redis