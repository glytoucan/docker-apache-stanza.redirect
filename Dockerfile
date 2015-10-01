FROM aokinobu/apache
MAINTAINER Nobuyuki Aoki "aokinobu@gmail.com"

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD 001-default.conf /etc/apache2/sites-available/001-default.conf

RUN a2ensite 000-default.conf
RUN a2ensite 001-default.conf
RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod proxy_http

EXPOSE 80 443
