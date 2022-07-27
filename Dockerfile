FROM rust:1.60.0 as builder-api
RUN apt-get update -qq && \
 apt-get install -y build-essential
COPY ./Ruby_milestone2/ /app
WORKDIR /app
RUN cd /app/ruby-api && cargo build --release

FROM rust:1.60.0 as builder-substrate
RUN apt-get update -qq && \
 apt-get install -y build-essential git curl make clang pkg-config libssl-dev && \
 rm -rf /var/lib/apt/lists/*
COPY ./zeropool_substrate/zk-substrate-devnet /app/zk-substrate-devnet
RUN cd /app/zk-substrate-devnet && make init && cargo +nightly-2020-10-05 build --release

FROM rust:1.60.0
WORKDIR /app
EXPOSE 3030 3031 3035 9944 3000
COPY ./entrypoint.sh ./
COPY ./rubyio-raw.json ./
COPY --from=builder-api /app/ruby-api/target/release/*-api ./
COPY --from=builder-substrate /app/zk-substrate-devnet/target/release/zeropool-substrate-node ./
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
