echo "Running post hook..."

mkdir /var/log/nginx || true;
wget https://raw.githubusercontent.com/elastic/examples/master/Common%20Data%20Formats/nginx_logs/nginx_logs -O /var/log/nginx/access.log;

cd /usr/share/filebeat;
service filebeat restart || true;
service filebeat status || true;

# curl -XPOST "http://localhost:9200/.kibana/doc/index-pattern:filebeat-" -H 'Content-Type: application/json' -d' { "type" : "index-pattern", "index-pattern" : { "title": "filebeat-*", "timeFieldName": "execution_time" } }'
