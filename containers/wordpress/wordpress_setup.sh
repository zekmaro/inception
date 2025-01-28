#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Wordpress configuration file not found. Setting it up."

  wp config create \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST} \
    --skip-check
  
  echo "WordPress configured."
fi

if [ ! -d /var/www/html/wp-content ]; then
  echo "WordPress not found. Installing it."

  wp core download --path=/var/www/html --allow-root
  wp core install \
    --url=${WORDPRESS_URL} \
    --title=${WORDPRESS_TITLE} \
    --admin_user=${WORDPRESS_ADMIN_USER} \
    --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

  echo "WordPress installed."
fi

chmod -R 755 /var/www/html
exec php-fpm