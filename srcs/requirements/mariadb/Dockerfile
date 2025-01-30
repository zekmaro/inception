FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server

COPY mariadb_setup.sh /usr/local/bin/mariadb_setup.sh

RUN chmod +x /usr/local/bin/mariadb_setup.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]