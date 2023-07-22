FROM ruby:3.2.2
WORKDIR /src
RUN gem install bundler
COPY Gemfile Gemfile.lock /src
RUN bundle