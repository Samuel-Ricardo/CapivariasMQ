
FROM elixir:1.17-alpine AS build


WORKDIR /app

RUN apk add --no-cache build-base git

RUN mix local.hex --force && mix local.rebar --forc

COPY mix.exs ./
RUN mix deps.get


COPY . .
RUN mix test && mix compile


FROM elixir:1.17-alpine

WORKDIR /app

COPY --from=build /app /app


EXPOSE 4000


CMD ["mix", "run", "./lib/capivariasmq.ex"]

