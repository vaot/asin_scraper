FROM ruby:2.6.3
MAINTAINER @vaot

RUN apt-get update && apt-get install -qy nginx curl nodejs nano build-essential chrpath libssl-dev libxft-dev libfreetype6-dev libfreetype6 libfontconfig1-dev

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
  ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/

WORKDIR /usr/src/app

RUN mkdir -p tmp/pids tmp/sockets tmp/cache tmp/sessions
RUN mkdir log

COPY . /usr/src/app
RUN ["/bin/sh", "-c", "bundle install"]

RUN bin/rake assets:precompile

EXPOSE 3000
