#!/bin/bash
set -e

# Create init SQL
cat > /etc/mysql/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Initialize database if needed
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Start mysqld in foreground
mysqld --init-file=/etc/mysql/init.sql --user=mysql &

MYSQL_PID=$!

# Forward SIGTERM/SIGINT to mysqld
trap "echo 'Stopping MariaDB...'; kill -TERM $MYSQL_PID; wait $MYSQL_PID; exit 0" SIGTERM SIGINT

# Wait for mysqld to exit
wait $MYSQL_PID
