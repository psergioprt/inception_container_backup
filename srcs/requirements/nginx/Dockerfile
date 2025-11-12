FROM debian:bookworm

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*

# Remove all default nginx configs
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default

# Copy my own Nginx config and SSL
COPY conf/nginx.conf /etc/nginx/conf.d/
COPY conf/ssl /etc/nginx/ssl

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
