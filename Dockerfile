FROM qazbnm456/fbctf_base:latest
MAINTAINER Lobsiinvok lobsiinvok@tdohacker.org

ENV HOME /root
ARG DOMAIN
ARG MODE=dev
CMD ["/sbin/my_init"]

WORKDIR $HOME
RUN apt-get update \
  && apt-get install -y git \
  && git clone https://github.com/facebook/fbctf

WORKDIR $HOME/fbctf
RUN ./extra/provision.sh dev `pwd`
RUN [ "$MODE" = "prod" ] && rm /etc/nginx/sites-available/fbctf.conf || true

ADD config.sh $HOME/fbctf/config.sh
ADD http_fbctf.conf /etc/nginx/sites-available/http_fbctf.conf
ADD https_fbctf.conf /etc/nginx/sites-available/https_fbctf.conf
RUN sed -i 's/domain.com/'$DOMAIN'/g' /etc/nginx/sites-available/http_fbctf.conf \
  && sed -i 's/domain.com/'$DOMAIN'/g' /etc/nginx/sites-available/https_fbctf.conf

RUN mkdir -p /etc/my_init.d
ADD setup_lets_encrypt.sh /etc/my_init.d/01_setup_lets_encrypt.sh
ADD service_startup.sh /etc/my_init.d/02_service_startup.sh
ADD import_empty_db.sh /etc/my_init.d/03_import_empty_db.sh
RUN [ "$MODE" = "dev" ] && rm /etc/my_init.d/01_setup_lets_encrypt.sh || true
RUN [ "$MODE" = "prod" ] && sed -i 's/domain.com/'$DOMAIN'/g' /etc/my_init.d/01_setup_lets_encrypt.sh || true
RUN sed -i 's/mode_arg/'$MODE'/g' /etc/my_init.d/03_import_empty_db.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
