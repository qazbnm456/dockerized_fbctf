FROM phusion/baseimage:latest
MAINTAINER Lobsiinvok lobsiinvok@tdohacker.org

ENV HOME /root
CMD ["/sbin/my_init"]

WORKDIR $HOME
RUN apt-get update \
  && apt-get install -y git \
  && git clone https://github.com/facebook/fbctf

WORKDIR $HOME/fbctf
RUN ./extra/provision.sh dev `pwd`
RUN rm /etc/nginx/sites-available/fbctf.conf

ADD import_empty_db.sh $HOME/fbctf/import_empty_db.sh
RUN service mysql start \
  && ./import_empty_db.sh

RUN mkdir -p /etc/my_init.d
ADD service_startup.sh /etc/my_init.d/01_service_startup.sh
ADD fbctf.conf /etc/nginx/sites-available/fbctf.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
