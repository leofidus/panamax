FROM panamaxrs/panamax:latest

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
