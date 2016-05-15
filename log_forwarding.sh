#!/bin/bash

# Forward access and error logs to docker log collector.
exec less +F /var/log/nginx/access.log
exec less +F /var/log/nginx/error.log
