FROM gerasim13/nodejs

COPY ./docker-entrypoint.sh /
ENV KIBANA_VERSION 4.3.0
ENV PATH /opt/kibana/bin:$PATH
RUN set -x \
	&& curl -fSL "https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz" -o kibana.tar.gz \
	&& tar -xz -C /opt -f kibana.tar.gz \
	&& rm kibana.tar.gz

EXPOSE 5601
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
