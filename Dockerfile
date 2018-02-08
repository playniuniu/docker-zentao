FROM alpine:latest
LABEL maintainer="playniuniu@gmail.com"

RUN apk add --no-cache --update php7-fpm php7-json php7-gd php7-mysqli \
    php7-pdo_mysql php7-curl php7-dom php7-session php7-iconv \
    php7-mbstring php7-zlib \
    && sed -i "s/^listen.*/listen = 0.0.0.0:9000/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/^user\ =.*/user = root/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/^group\ =.*/group = root/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/^doc_root\ =.*/doc_root = \/opt\/web/g" /etc/php7/php.ini \
    && sed -i "s/^;session\.save_path\(.*\)/session\.save_path\1/g" /etc/php7/php.ini \
    && mkdir -p /opt/web

WORKDIR /opt/web
EXPOSE 9000
CMD [ "php-fpm7", "-R", "-F" ]
