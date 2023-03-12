  docker run \
    --name elasticsearch-rails-searchapp \
    --publish 9200:9200 \
    --env "discovery.type=single-node" \
    --env "cluster.name=elasticsearch-rails" \
    --env "cluster.routing.allocation.disk.threshold_enabled=false" \
    --rm \
    docker.elastic.co/elasticsearch/elasticsearch:7.6.0

#Pessoa.__elasticsearch__.create_index! force: true
#Pessoa.import force: true 

curl -X GET 'http://localhost:9200'