FROM rust:1.60.0
LABEL MAINTAINER="miles.huang@muadao.build"

RUN apt-get update -qq && \
 apt-get install -y build-essential git curl make clang pkg-config libssl-dev && \
 rm -rf /var/lib/apt/lists/*
COPY . /app
WORKDIR /app/zk-substrate-devnet
EXPOSE 9944
RUN make init && cargo +nightly-2020-10-05 build --release 
CMD make run
