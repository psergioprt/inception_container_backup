FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server && rm -rf /var/lib/apt/lists/*

# Create the directory for the MariaDB socket
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Copy modified config
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY mariadb-run.sh /mariadb-run.sh
RUN chmod +x /mariadb-run.sh

# Start the server in foreground for Docker
ENTRYPOINT ["/mariadb-run.sh"]
