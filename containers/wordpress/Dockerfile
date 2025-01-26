FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    php-fpm \
    curl \
    wget \
    unzip && \
    apt-get clean

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xvzf wordpress.tar.gz -C /var/www/html \
    && rm wordpress.tar.gz

WORKDIR /var/www/html

EXPOSE 9000