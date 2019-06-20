FROM ruby:2.6.3
MAINTAINER @vaot

RUN apt-get update && apt-get install -qy nginx curl nodejs nano

WORKDIR /usr/src/app

RUN mkdir -p tmp/pids tmp/sockets tmp/cache tmp/sessions
RUN mkdir log

COPY . /usr/src/app
RUN ["/bin/sh", "-c", "bundle install"]

EXPOSE 3000
