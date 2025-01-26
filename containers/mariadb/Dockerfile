FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server

COPY mariadb_setup.sh /usr/local/bin/mariadb_setup.sh

RUN chmod +x /usr/local/bin/mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]