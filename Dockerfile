FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

COPY script.sh /var/www/script.sh

RUN chmod +x /var/www/script.sh

CMD ["/var/www/script.sh"]
