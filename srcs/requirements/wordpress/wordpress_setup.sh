#!/bin/bash

echo "Waiting for MariaDB to be ready..."

echo "Database is up!"

if [ -f /var/www/html/wp-config.php ]; then
  rm -f /var/www/html/wp-config.php
fi

echo "Wordpress configuration file not found. Setting it up."

wp config create \
  --dbname=${WORDPRESS_DB_NAME} \
  --dbuser=${WORDPRESS_DB_USER} \
  --dbpass=${WORDPRESS_DB_PASSWORD} \
  --dbhost=${WORDPRESS_DB_HOST} \
  --skip-check \
  --allow-root

echo "WordPress configured."

wp core install \
  --url=${WORDPRESS_URL} \
  --title=${WORDPRESS_TITLE} \
  --admin_user=${WORDPRESS_ADMIN_USER} \
  --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
  --admin_email=${WORDPRESS_ADMIN_EMAIL} \
  --skip-email \
  --allow-root

echo "WordPress installed."

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

chown -R www-data:www-data /run/php
chmod -R 755 /run/php

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.4 -F