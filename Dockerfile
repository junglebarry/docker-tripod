FROM       ubuntu:14.04
MAINTAINER David Brooks (db@talis.com)

ENV mongo_version=2.4.0

# Adds mongodb repositories to apt
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

RUN apt-get update

# Install and configure mongodb
RUN     apt-get install -y mongodb-10gen=${mongo_version}
RUN     mkdir -p /data/db
EXPOSE  27017

# Install and configure redis
RUN     apt-get install -y redis-server redis-tools
EXPOSE  6379

# Install Tripod dependencies
RUN apt-get install -y ant php5 php5-mongo

# Mount the working directory
WORKDIR    /talis/tripod-php

# Run services and enter
ADD  ./run-tripod-services.sh /usr/bin/run-tripod-services.sh
CMD  bash -C "/usr/bin/run-tripod-services.sh";"bash"