FROM rust:latest AS builder

WORKDIR /app

#ADD --chown=rust:rust . /app/
ADD . /app/

ARG CARGO_BUILD_EXTRA
RUN cargo build --release $CARGO_BUILD_EXTRA

FROM debian:latest

COPY --from=builder /app/target/release/panamax /usr/local/bin

RUN apt update \
  && apt install -y \
    ca-certificates \
    git \
    libssl1.1 \
    cron \
    dos2unix \
  && git config --global --add safe.directory '*'

COPY cron-sync /etc/cron.d/cron-sync
RUN dos2unix /etc/cron.d/cron-sync
RUN chmod 0644 /etc/cron.d/cron-sync
RUN crontab /etc/cron.d/cron-sync

COPY start.sh start.sh

EXPOSE 8080

ENTRYPOINT ["bash", "./start.sh" ]
CMD []
