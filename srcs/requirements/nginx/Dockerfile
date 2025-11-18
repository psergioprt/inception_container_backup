FROM debian:bookworm

ARG CRED_PATH CRED_CERT CRED_KEY COUNTRY STATE LOCALITY ORGANIZATION ORG_UNIT COMMON_NAME

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${CRED_PATH}

# Remove all default nginx configs
#RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout ${CRED_PATH}/${CRED_KEY} \
    -out ${CRED_PATH}/${CRED_CERT} \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${ORG_UNIT}/CN=${COMMON_NAME}"

# Copy my own Nginx config and SSL
# COPY conf/nginx.conf /etc/nginx/conf.d/

# Copy nginx.conf to temporary location for variable substitution 
COPY conf/nginx.conf /tmp/nginx.conf

# Replace placeholders in nginx.conf with build args and move to final location
RUN envsubst '$CRED_PATH $CRED_KEY $CRED_CERT $COMMON_NAME' < /tmp/nginx.conf > /etc/nginx/sites-available/default


# Run Nginx config
#RUN mkdir -p /etc/nginx/ssl \
#    && openssl req -x509 -nodes -days 365 \
#    -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/nginx.key \
#    -out /etc/nginx/ssl/nginx.crt \
#    -subj "/C=PT/ST=Porto/L=Porto/O=42Porto/OU=Cadet/CN=pauldos-.42.fr"

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
