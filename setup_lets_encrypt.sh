#!/bin/bash

set -e

curl -h >/dev/null 2>&1 || { echo >&2 "Curl is needed but I cannot find that. Aborting."; exit 1; }
openssl -h >/dev/null 2>&1 || { echo >&2 "Openssl is needed but I cannot find that. Aborting."; exit 1; }

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $PWD \
    && git clone https://github.com/lukas2511/letsencrypt.sh.git \
    && cd letsencrypt.sh && echo domain.com > domains.txt \
    && mkdir -p /var/www/fbctf/src/.well-known/acme-challenge \
    && chmod 755 /var/www/fbctf \
    && mv /root/fbctf/config.sh . \
    && echo "Enable the http endpoint" \
    && ln -s /etc/nginx/sites-available/http_fbctf.conf /etc/nginx/sites-enabled/http_fbctf.conf \
    && echo "Start nginx service..." \
    && service nginx start \
    && echo "Generate Letsencrypt SSL certificates" \
    && ./letsencrypt.sh -c \
    && echo "Enable the https endpoint" \
    && ln -s /etc/nginx/sites-available/https_fbctf.conf /etc/nginx/sites-enabled/https_fbctf.conf \
    && echo "Reload nginx service..." \
    && service nginx reload
