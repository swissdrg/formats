FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /formats
WORKDIR /formats
COPY Gemfile /formats/Gemfile
COPY Gemfile.lock /formats/Gemfile.lock
RUN bundle install
COPY . /formats
