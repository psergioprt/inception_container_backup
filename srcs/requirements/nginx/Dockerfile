FROM debian:bookworm

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*

# Remove all default nginx configs
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default

# Copy my own Nginx config and SSL
COPY conf/nginx.conf /etc/nginx/conf.d/

# Run Nginx config
RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=PT/ST=Porto/L=Porto/O=42Porto/OU=Cadet/CN=pauldos-.42.fr"

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
