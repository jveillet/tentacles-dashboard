FROM ruby:2.6.3

ARG APP_HOME=/home/rails/tentacles

RUN apt-get update -qq && apt-get install -y apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get install -y libpq-dev nodejs yarn postgresql-client

# Create a non-root user
RUN groupadd -r rails && useradd -m -r -g rails rails

# Creating the path to the vendor directory because we have private gems
# that need to be installed and Docker fails to assume the correct
# permissions.
RUN mkdir -p ${APP_HOME} && chown -R rails:rails ${APP_HOME}

WORKDIR ${APP_HOME}

USER rails

COPY --chown=rails:rails package* ./
COPY --chown=rails:rails yarn.lock ./
COPY --chown=rails:rails Gemfile* ./

RUN yarn install
RUN bundle install

COPY --chown=rails:rails . ./

# Add a script to be executed every time the container starts.
COPY --chown=rails:rails entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
