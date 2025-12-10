FROM debian:bookworm

ARG CRED_PATH CRED_CERT CRED_KEY COUNTRY STATE LOCALITY ORGANIZATION ORG_UNIT COMMON_NAME

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y nginx openssl gettext-base

RUN mkdir -p ${CRED_PATH}

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout ${CRED_PATH}/${CRED_KEY} \
    -out ${CRED_PATH}/${CRED_CERT} \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${ORG_UNIT}/CN=${COMMON_NAME}"

# Copy nginx.conf to temporary location for variable substitution 
COPY conf/nginx.conf /tmp/nginx.conf

# Replace placeholders in nginx.conf with build args and move to final location
RUN envsubst '$CRED_PATH $CRED_KEY $CRED_CERT $COMMON_NAME' < /tmp/nginx.conf > /etc/nginx/sites-available/default

EXPOSE 443
ENTRYPOINT ["nginx", "-g", "daemon off;"]
