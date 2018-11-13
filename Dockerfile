FROM sebp/elk:latest

RUN echo "Building .... "

ENV ES_HOME /opt/elasticsearch
WORKDIR ${ES_HOME}

RUN yes | CONF_DIR=/etc/elasticsearch gosu elasticsearch bin/elasticsearch-plugin install -b ingest-geoip
RUN yes | CONF_DIR=/etc/elasticsearch gosu elasticsearch bin/elasticsearch-plugin install -b ingest-user-agent

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.3-amd64.deb;
RUN dpkg -i filebeat-6.4.3-amd64.deb;

WORKDIR /usr/share/filebeat
RUN filebeat modules enable nginx -c /etc/filebeat/filebeat.yml
RUN service filebeat restart || true;
RUN service filebeat status || true;

RUN apt-get install wget -y

ADD ./post-hook.sh /usr/local/bin/elk-post-hooks.sh
RUN chmod +x /usr/local/bin/elk-post-hooks.sh