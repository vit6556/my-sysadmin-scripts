FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends procps python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

COPY script.sh /var/www/script.sh

RUN chmod +x /var/www/script.sh

EXPOSE 8080

CMD ["/bin/bash", "-c", "./script.sh & exec python3 -m http.server 8080 --bind 0.0.0.0"]
