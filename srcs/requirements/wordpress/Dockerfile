FROM debian:bookworm

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y \
		php8.2-fpm php8.2-mysqli curl vim nano default-mysql-client \
	&& rm -rf /var/lib/apt/lists/*

# Create /run/php directory and set permissions
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Copy PHP-FPM pool configuration
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/.

COPY install_wordpress.sh /install_wordpress.sh
RUN chmod +x /install_wordpress.sh
# Keep container running with PHP-FPM in foreground
ENTRYPOINT ["/install_wordpress.sh"]

