FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server && rm -rf /var/lib/apt/lists/*

# Create the directory for the MariaDB socket
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Copy modified config
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy init.sql
COPY init.sql /etc/mysql/init.sql

COPY mariadb_start.sh /mariadb_start.sh
RUN chmod +x /mariadb_start.sh

# Start the server in foreground for Docker
ENTRYPOINT ["/mariadb_start.sh"]
