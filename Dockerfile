FROM marcelocg/phoenix
MAINTAINER david.morcillo@codegram.com

ARG mix_env=prod
ARG port=4000

RUN apt-get update && apt-get install -y postgresql-client erlang-xmerl elixir

ENV APP_HOME /code
ENV MIX_ENV $mix_env
ENV PORT $port

WORKDIR $APP_HOME

ADD package.json /tmp/package.json
ADD mix.exs /tmp/mix.exs
ADD mix.lock /tmp/mix.lock

RUN cd /tmp && yes | mix deps.get && yes | mix deps.compile && \
      cp -a /tmp/deps $APP_HOME

RUN cd /tmp && npm install && mkdir -p $APP_HOME && \
    cp -a /tmp/node_modules $APP_HOME

ADD . $APP_HOME

RUN bash -c "mix compile 1>&1"

RUN bash -c "mix phoenix.digest 1>&1"

CMD ["mix", "phoenix.server"]

