FROM php:7.4-fpm

ENV TZ Asia/Shanghai

RUN docker-php-ext-install pdo_mysql \
    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && curl -L -o /tmp/redis.tar.gz  http://pecl.php.net/get/redis-5.3.1.tgz \
    && tar zxvf /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv ./redis-5.3.1 /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#    && docker-php-ext-install -j$(nproc) gd \
    #删除包缓存中的所有包
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*