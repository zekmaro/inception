FROM debian:buster

RUN apt-get update && apt-get install -y php php-mysqli curl wget unzip

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xvzf wordpress.tar.gz -C /var/www/html \
    && rm wordpress.tar.gz

WORKDIR /var/www/html

EXPOSE 9000