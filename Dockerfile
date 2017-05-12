FROM registry:5000/infra/nginx:1.13.0
MAINTAINER Christoph Lukas <christoph.lukas@gmx.net>

ENV DEBIAN_FRONTEND noninteractive
ARG ARTEFACT_FILE

RUN dpkg-divert --package phonebook-frontend --add --rename --divert /usr/share/nginx/html/index.html.nginx /usr/share/nginx/html/index.html

COPY target/$ARTEFACT_FILE /tmp/
RUN dpkg -i "/tmp/$ARTEFACT_FILE" && rm -f "/tmp/$ARTEFACT_FILE"
