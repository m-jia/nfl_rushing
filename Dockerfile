FROM elixir:1.10

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get install -y inotify-tools && \
    apt-get install -y nodejs && \
    curl -L https://npmjs.org/install.sh | sh && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.5.3 --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

COPY mix.* ./
RUN mix deps.get
RUN mix deps.compile

COPY . .
RUN cd assets && npm install && npm rebuild node-sass