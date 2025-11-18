#!/bin/bash

cd /var/www/html

# Download WP-CLI if missing
if [ ! -f wp-cli.phar ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
fi

if [ ! -f index.php ]; then
	./wp-cli.phar core download --allow-root
fi

if [ ! -f wp-config.php ]; then
        ./wp-cli.phar config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}" \
--dbhost="${DB_HOST}" --allow-root
fi

if ! ./wp-cli.phar core is-installed --allow-root &>/dev/null; then
        ./wp-cli.phar core install --url="${WP_DOMAIN}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" \
                --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
fi

# Check if user exists
if ! ./wp-cli.phar user get "${WP_ADMIN_USER}" --allow-root &>/dev/null; then
    ./wp-cli.phar user create "${WP_ADMIN_USER}" "${WP_ADMIN_EMAIL}" \
        --role=administrator --user_pass="${WP_ADMIN_PASSWORD}" --allow-root
else
    ./wp-cli.phar user update "${WP_ADMIN_USER}" \
        --user_pass="${WP_ADMIN_PASSWORD}" --user_email="${WP_ADMIN_EMAIL}" --allow-root
fi

if ! ./wp-cli.phar user get "${WP_GUEST_USER}" --allow-root &>/dev/null; then
        ./wp-cli.phar user create "${WP_GUEST_USER}" "${WP_GUEST_EMAIL}" --role=subscriber --user_pass="${WP_GUEST_PASSWORD}" --allow-root
fi

php-fpm8.2 -F
