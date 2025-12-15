#!/bin/bash
set -e

# Create init SQL
cat > /etc/mysql/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
DROP USER 'root'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Initialize database if needed
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Start mysqld in foreground
exec mysqld --init-file=/etc/mysql/init.sql --user=mysql
