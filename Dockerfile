FROM brunoric/hhvm:deb-hhvm
MAINTAINER AlexGaspar Lobsiinvok lobsiinvok@tdohacker.org

ENV CTF_PATH /var/www/fbctf
ENV DEBIAN_FRONTEND noninteractive
ENV CTF_REPO https://github.com/facebook/fbctf.git

RUN apt-get update \
  && apt-get install -y --force-yes curl language-pack-en git npm nodejs-legacy nginx mysql-client

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p $CTF_PATH
WORKDIR $CTF_PATH

# Install CTF
RUN git clone --depth 1 $CTF_REPO .

# Install Vendors
RUN composer install

# Build assets
RUN npm install && npm install -g grunt && npm install -g flow-bin
RUN grunt

# Add nginx configuration
COPY fbctf.conf /etc/nginx/sites-available/fbctf.conf
COPY http_fbctf.conf /etc/nginx/sites-available/http_fbctf.conf
COPY https_fbctf.conf /etc/nginx/sites-available/https_fbctf.conf

COPY ["settings.env.ini", "entrypoint.sh", "./"]

ENTRYPOINT ["./entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
