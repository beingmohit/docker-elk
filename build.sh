./clean.sh
sudo sysctl -w vm.max_map_count=262144
export KIBANA_CONNECT_RETRY=12000
export ES_CONNECT_RETRY=12000
export ES_JAVA_OPTS='-Xms256m -Xmx256m' 
docker-compose up --build -d
docker-compose logs -f -t