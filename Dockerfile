FROM kube-registry.kube-system.svc.cluster.local:5000/ruby-phonebook:019ab7bab4cc
MAINTAINER Christoph Lukas <christoph.lukas@gmx.net>

ENV DEBIAN_FRONTEND noninteractive
ARG ARTEFACT_URL

RUN ARTEFACT_FILE=$(basename $ARTEFACT_URL); \
  wget -q -O "/tmp/$ARTEFACT_FILE" "$ARTEFACT_URL" && \
  dpkg -i "/tmp/$ARTEFACT_FILE" && rm -f "/tmp/$ARTEFACT_FILE"

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
