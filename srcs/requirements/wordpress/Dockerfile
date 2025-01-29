FROM debian:buster

RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    mariadb-client \
    php-fpm \
    curl \
    wget \
    unzip && \
    apt-get clean

RUN mkdir -p /var/www/html

RUN mkdir -p /run/php

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xvzf wordpress.tar.gz -C /var/www/html \
    && rm wordpress.tar.gz

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN wp core download --path=/var/www/html --allow-root

WORKDIR /var/www/html

COPY wordpress_setup.sh /usr/local/bin/wordpress_setup.sh

RUN chmod +x /usr/local/bin/wordpress_setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]