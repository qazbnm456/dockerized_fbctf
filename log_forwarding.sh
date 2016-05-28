#!/bin/bash
# Forwards the Nginx access.log to the Docker logs.
set -e
if [[ -e /var/log/nginx/access.log ]]; then
        exec tail -F /var/log/nginx/access.log
else
        exec sleep 10
fi
