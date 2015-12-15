FROM gerasim13/nodejs

COPY ./docker-entrypoint.sh /

RUN addgroup -S kibana && adduser -S -D -H -G kibana kibana
RUN apk --update add bash
ENV KIBANA_VERSION 4.3.0
ENV PATH /opt/kibana/bin:$PATH

RUN set -x \
  && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
  && curl -fSL "https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz" -o /tmp/kibana.tar.gz \
  && chmod +x /usr/local/bin/gosu \
  && mkdir -p /opt \
	&& tar -xz -C /opt -f /tmp/kibana.tar.gz \
  && rm /opt/kibana-${KIBANA_VERSION}-linux-x64/node/bin/node \
  && rm /opt/kibana-${KIBANA_VERSION}-linux-x64/node/bin/npm \
  && mv /opt/kibana-${KIBANA_VERSION}-linux-x64 /opt/kibana \
  && chown -R kibana:kibana /opt/kibana \
	&& rm /tmp/kibana.tar.gz \
  && rm -rf /var/cache/apk/*

EXPOSE 5601
CMD ["bash", "/docker-entrypoint.sh", "kibana"]
