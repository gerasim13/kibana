FROM gerasim13/nodejs

COPY ./docker-entrypoint.sh /
RUN apk --update add bash
RUN bash /docker-entrypoint.sh
ENV KIBANA_VERSION 4.3.0
ENV PATH /opt/kibana/bin:$PATH
RUN set -x \
  && curl -fSL "https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz" -o /tmp/kibana.tar.gz \
  && mkdir -p /opt \
	&& tar -xz -C /opt -f /tmp/kibana.tar.gz \
  && mv /opt/kibana-${KIBANA_VERSION}-linux-x64 /opt/kibana \
	&& rm /tmp/kibana.tar.gz

EXPOSE 5601
ENTRYPOINT ["/bin/bash /docker-entrypoint.sh"]
CMD ["kibana"]
