FROM php:7.2.6-apache-stretch
MAINTAINER BBOYSOULCN@GMAIL.COM
ENV KODEXPLORE-VERSION=4.25
WORKDIR /var/www/html/
COPY kodexplorer /var/www/html/kodexplorer
COPY kodexplorer.conf /etc/apache2/sites-available/ 
COPY kodexplorer.conf /etc/apache2/sites-enabled/
RUN set -x \
    && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt-get update \
    && chown -Rf www-data:www-data kodexplorer \
    && rm -rf /etc/apache2/sites-available/000-default.conf \
    && rm -rf /etc/apache2/sites-enabled/000-default.conf \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd \
    && apt-get clean
VOLUME [ "/var/www/html/kodexplorer" ]
EXPOSE 80




