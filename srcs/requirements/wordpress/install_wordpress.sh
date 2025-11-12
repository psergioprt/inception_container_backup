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
	./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
fi
if ! ./wp-cli.phar core is-installed --allow-root &>/dev/null; then
	./wp-cli.phar core install --url=localhost --title=inception --admin_user=pauldos- \
		--admin_password=123456 --admin_email=pauldos-@inception.com --allow-root
fi

CUSTOM_USER="pauldos-"
CUSTOM_PASS="123456"
CUSTOM_EMAIL="pauldos-@inception.com"

# Check if user exists
if ! ./wp-cli.phar user get "$CUSTOM_USER" --allow-root &>/dev/null; then
    # Create user if missing
    ./wp-cli.phar user create "$CUSTOM_USER" "$CUSTOM_EMAIL" \
        --role=administrator --user_pass="$CUSTOM_PASS" --allow-root
else
    # Update password and email if user exists
    ./wp-cli.phar user update "$CUSTOM_USER" \
        --user_pass="$CUSTOM_PASS" --user_email="$CUSTOM_EMAIL" --allow-root
fi

php-fpm8.2 -F
