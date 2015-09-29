FROM ruby:2.1.5
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config –global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app

RUN apt-get update && \
apt-get install -y nodejs –no-install-recommends && \
rm -rf /var/lib/apt/lists/*

ONBUILD RUN bundle exec rake db:migrate
EXPOSE 80
CMD ["rails", "server"]