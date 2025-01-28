#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
  echo "Initializing MariaDB"

  mysqld --initialize-insecure --datadir=/var/lib/mysql
  echo "Database initialized."

  mysqld --skip-networking
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
  if [ -n "${MYSQL_DATABASE}" ]; then
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    echo "Database created."
  fi
  if [ -n "${MYSQL_USER}" ] && [ -n "${MYSQL_PASSWORD}" ]; then
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@\`%\` IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@\`%\`;"
    echo "User created."
  fi
  echo "MariaDB configured."
else
  echo "Starting MariaDB"
  mysqld
fi