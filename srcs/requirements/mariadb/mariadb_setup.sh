#!/bin/bash

# Ensure MySQL socket directory exists (only if missing)
if [ ! -d /run/mysqld ]; then
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
  echo "[INFO] Created /run/mysqld directory."
fi

# Initialize database if not already initialized
if [ ! -d /var/lib/mysql/mysql ]; then
  echo "[INFO] Initializing MariaDB..."

  # Initialize database
  mysqld --initialize-insecure --datadir=/var/lib/mysql
  echo "[INFO] Database initialized."

  # Start MariaDB temporarily to configure it
  mysqld --skip-networking --socket=/run/mysqld/mysqld.sock &
  pid="$!"

  # Wait for MariaDB to be ready
  sleep 5

  # Set root password
  echo "[INFO] Setting root password..."
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

  # Create database if specified
  if [ -n "${MYSQL_DATABASE}" ]; then
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    echo "[INFO] Database '${MYSQL_DATABASE}' created."
  fi

  # Create user with both localhost and remote access
  # if [ -n "${MYSQL_USER}" ] && [ -n "${MYSQL_PASSWORD}" ]; then
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost';"

  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
  echo "[INFO] User '${MYSQL_USER}' created with access to '${MYSQL_DATABASE}'."
  # fi

  # Stop temporary MariaDB process
  echo "[INFO] Shutting down temporary MariaDB instance..."
  mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

  echo "[INFO] Configuring MariaDB networking..."
  echo "[mysqld]" > /etc/mysql/my.cnf
  echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf

  echo "[INFO] MariaDB setup complete."
fi

echo "[INFO] Starting MariaDB..."
exec mysqld
