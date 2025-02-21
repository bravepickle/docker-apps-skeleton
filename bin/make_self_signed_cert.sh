#!/bin/bash
# Create self-signed certificate based on .env file provided settings
# See references
#   * https://doc.traefik.io/traefik/user-guides/grpc/#with-https
#   * https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html
#   * https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm
#   * https://devcenter.heroku.com/articles/ssl-certificate-self

set -e

source $(dirname "$0")/common_init.sh

TARGET_DIR="${BASE_DIR}/var/ssl-certs"

if [ ! -d $TARGET_DIR ]; then
    echo "Creating directory for SSL certs: ${TARGET_DIR}..."

    mkdir -p $TARGET_DIR
fi

cd $TARGET_DIR
# pwd

echo "Processing SSL certs in folder ${TARGET_DIR}..."

# # Generate private key and certificate signing request
# openssl genrsa -aes256 -passout pass:"${APP_SSL_PASSPHRASE}" -out ${APP_HOST}.pass.key 4096
# openssl rsa -passin pass:"${APP_SSL_PASSPHRASE}" -in ${APP_HOST}.pass.key -out ${APP_HOST}.key

# rm ${APP_HOST}.pass.key

# # Generate SSL certificate
# openssl req -new -key ${APP_HOST}.key -out ${APP_HOST}.csr -subj "/C=UA/ST=None/L=None/O=None/OU=root/CN=${APP_HOST}/emailAddress=support@${APP_HOST}"
# openssl x509 -req -sha256 -days 3650 -in ${APP_HOST}.csr -signkey ${APP_HOST}.key -out ${APP_HOST}.crt

if [[ "${APP_SSL_PASSPHRASE}" == "" ]]; then
    openssl req -newkey rsa:2048 \
                -x509 \
                -sha256 \
                -subj "/C=UA/ST=None/L=None/O=None/OU=root/CN=${APP_HOST}/emailAddress=support@${APP_HOST}" \
                -days 3650 \
                -nodes \
                -out ${APP_HOST}.crt \
                -keyout ${APP_HOST}.key
else
    openssl req -newkey rsa:2048 \
                -x509 \
                -sha256 \
                -subj "/C=UA/ST=None/L=None/O=None/OU=root/CN=${APP_HOST}/emailAddress=support@${APP_HOST}" \
                -days 3650 \
                -passout pass:"${APP_SSL_PASSPHRASE}" \
                -out ${APP_HOST}.crt \
                -keyout ${APP_HOST}.key
fi

# Make PEM file just in case it is needed
cat "${APP_HOST}.crt" "${APP_HOST}.key" | tee "${APP_HOST}.pem"
