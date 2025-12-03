#!/bin/bash
set -e

cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sleep 5
./wp-cli.phar core download --allow-root
./wp-cli.phar config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=${DB_HOST} --allow-root
./wp-cli.phar core install --url=${WP_DOMAIN} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
./wp-cli.phar user create ${WP_GUEST_USER} ${WP_GUEST_EMAIL} --role=subscriber --user_pass=${WP_GUEST_PASSWORD} --allow-root

php-fpm8.2 -F &
PHP_FPM_PID=$!

# Trap SIGTERM and SIGINT and forward to PHP-FPM
trap "echo 'Stopping PHP-FPM...'; kill -TERM $PHP_FPM_PID; wait $PHP_FPM_PID; exit 0" SIGTERM SIGINT

# Wait for PHP-FPM to exit
wait $PHP_FPM_PID
