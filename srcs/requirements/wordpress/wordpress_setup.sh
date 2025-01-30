#!/bin/bash

echo "Waiting for MariaDB to be ready..."

# max_retries=30
# retry_delay=2
# retries=0

# while ! mysqladmin ping -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" --silent; do
#   retries=$((retries+1))
#   echo "Waiting for database... Attempt $retries/$max_retries"
  
#   if [ $retries -ge $max_retries ]; then
#     echo "Database failed to start after $max_retries attempts."
#     exit 1
#   fi

#   sleep $retry_delay
# done

echo "Database is up!"

if [ -f /var/www/html/wp-config.php ]; then
  rm -f /var/www/html/wp-config.php
fi

echo "Wordpress configuration file not found. Setting it up."

cat ${WORDPRESS_DB_NAME}

wp config create \
  --dbname=${WORDPRESS_DB_NAME} \
  --dbuser=${WORDPRESS_DB_USER} \
  --dbpass=${WORDPRESS_DB_PASSWORD} \
  --dbhost=${WORDPRESS_DB_HOST} \
  --skip-check \
  --allow-root

echo "WordPress configured."

cat /var/www/html/wp-config.php

echo "WordPress not found. Installing it. Setting up admin user."

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

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.3 -F