FROM gerasim13/nodejs

ENV KIBANA_VERSION 4.3.0
ADD https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz /tmp/kibana-${KIBANA_VERSION}-linux-x64.tar.gz
RUN tar xzf /tmp/kibana-${KIBANA_VERSION}-linux-x64.tar.gz -C / && \
    rm /kibana-${KIBANA_VERSION}-linux-x64/node/bin/node && \
    rm /kibana-${KIBANA_VERSION}-linux-x64/node/bin/npm && \
    ln -s /usr/bin/node /kibana-${KIBANA_VERSION}-linux-x64/node/bin/node && \
    ln -s /usr/bin/npm /kibana-${KIBANA_VERSION}-linux-x64/node/bin/npm && \
    sed -i '/elasticsearch_url/s/localhost/elasticsearch/' /kibana-${KIBANA_VERSION}-linux-x64/config/kibana.yml

RUN apk del build-base gfortran && \
    rm -rf /root/.cache/pip/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

EXPOSE 5601
CMD ["/kibana-4.0.2-linux-x64/bin/kibana"]
