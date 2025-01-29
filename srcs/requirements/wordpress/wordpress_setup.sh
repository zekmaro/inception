#!/bin/bash

log "Waiting for MariaDB to be ready..."

max_retries=30
retry_delay=5
retries=0

while ! mysqladmin ping -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" --silent; do
  sleep $retry_delay
  retries=$((retries+1))
  if [ ! $retries -ge $max_retries ]; then
    log "db failed"
    exit 1
  fi
done

log "MariaDB is ready!"

if [ ! -f /var/www/html/wp-config.php ]; then
  log "Wordpress configuration file not found. Setting it up."

  wp config create \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST} \
    --skip-check
  
  log "WordPress configured."
fi

if [ ! -d /var/www/html/wp-content ]; then
  log "WordPress not found. Installing it. Setting up admin user."

  wp core install \
    --url=${WORDPRESS_URL} \
    --title=${WORDPRESS_TITLE} \
    --admin_user=${WORDPRESS_ADMIN_USER} \
    --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
    --skip-email \

  log "WordPress installed."
fi

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
exec php-fpm