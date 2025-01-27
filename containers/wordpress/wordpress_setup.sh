#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
  echo "WordPress not found. Installing WordPress"

  mkdir -p /var/www/html

  curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xvzf wordpress.tar.gz -C /var/www/html \
    && rm wordpress.tar.gz
  
  echo "WordPress installed."
else
  echo "WordPress already installed."
fi

