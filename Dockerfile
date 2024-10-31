FROM elixir:1.17.2-otp-26-alpine as builder

ARG APP_NAME

ADD . /app

WORKDIR /app

ENV MIX_ENV=prod

RUN apk add git

RUN mix do \
      local.hex --force, \
      local.rebar --force, \
      deps.get, \
      deps.compile

RUN mix release "${APP_NAME}"

RUN git log --pretty=format:"%H %cd %s" > commits.txt

FROM alpine:3.20

ARG APP_NAME

RUN apk add --no-cache \
      tini \
      ncurses-libs \
      zlib \
      ca-certificates \
      libstdc++ \
      openssl \
      bash

WORKDIR /app

COPY --from=builder /app/_build /app
COPY --from=builder /app/commits.txt /app

ENV REPLACE_OS_VARS=true \
      APP=${APP_NAME}

ENTRYPOINT ["/sbin/tini", "--"]

CMD prod/rel/${APP}/bin/${APP} eval "Elixir.EHCS.UC6.ReleaseTasks.migrate" && prod/rel/${APP}/bin/${APP} start
