FROM php:7.3-apache-buster

# Install website
COPY ./src/ /var/www/html
COPY entrypoint.sh /entrypoint.sh

# Install Node-Media-Server
RUN apt-get -y install nodejs wget
RUN mkdir /nms && cd /nms && wget https://github.com/illuspas/Node-Media-Server/archive/v2.1.4.tar.gz && tar zxvf v2.1.4.tar.gz && cd Node-Media-Server-2.1.4 && rm -rf app.js
COPY app.js /nms/Node-Media-Server-2.1.4/app.js
RUN cd /nms/Node-Media-Server-2.1.4 && npm i

# Start container
EXPOSE 80 8000 1935
ENTRYPOINT "/entrypoint.sh"
