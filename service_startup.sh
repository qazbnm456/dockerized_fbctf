#!/bin/bash

rm -f /etc/nginx/sites-enabled/fbctf_http.conf
service nginx start
service mysql start
service hhvm start

