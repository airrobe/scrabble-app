FROM ruby:2.6.5

WORKDIR /usr/src/app

COPY Gemfile ./
RUN bundle install

COPY . .

CMD ["./bin/scrabble"]
