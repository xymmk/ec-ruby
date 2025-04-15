FROM ruby:latest

COPY . /app
RUN apt-get update && \
    apt-get install vim -y && \
    apt-get install -y postgresql-client && \
    gem update && \
    gem install rails && \
    cd /app/ec && bundle install