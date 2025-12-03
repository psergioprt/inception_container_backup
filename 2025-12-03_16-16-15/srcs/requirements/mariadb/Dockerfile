FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY mariadb-run.sh /mariadb-run.sh
RUN chmod +x /mariadb-run.sh

ENTRYPOINT ["/mariadb-run.sh"]
