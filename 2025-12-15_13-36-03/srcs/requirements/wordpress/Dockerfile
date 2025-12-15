FROM debian:bookworm

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y \
		php8.2-fpm php8.2-mysqli curl default-mysql-client

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/.

COPY install_wordpress.sh /install_wordpress.sh
RUN chmod +x /install_wordpress.sh
ENTRYPOINT ["/install_wordpress.sh"]

