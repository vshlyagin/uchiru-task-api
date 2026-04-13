FROM ruby:3.4.3

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  postgresql-client \
  libpq-dev

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0"]