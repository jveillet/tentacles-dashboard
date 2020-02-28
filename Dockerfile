FROM ruby:2.6.5

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV BUNDLE_JOBS=10
ENV BUNDLER_VERSION=2.0.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update -y \
    && apt-get install -y \
    apt-transport-https \
    libpq-dev \
    nodejs \
    yarn \
    postgresql-client

RUN gem install bundler -v 2.0.2

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile* ./

RUN bundle config
RUN bundle install

COPY package.json yarn.lock ./

RUN yarn install --check-files

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec ", "rails", "s", "-p", "3000" , "-b", '0.0.0.0']
