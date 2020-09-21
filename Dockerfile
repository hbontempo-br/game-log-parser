FROM ruby:2.7.1

RUN mkdir /game-log-parser
WORKDIR /game-log-parser

ADD Gemfile Gemfile.lock /game-log-parser/
RUN gem install bundler
RUN bundle install --without test

ADD . /game-log-parser/

CMD ["bundle", "exec", "rackup", "app/config.ru", "--host", "0.0.0.0", "-p", "3000"]