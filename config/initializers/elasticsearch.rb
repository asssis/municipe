config = {
  host: "http://es-container:9200/",
  transport_options: {
    request: { timeout: 5 }
  }
}

if File.exists?("config/elasticsearch.yml")
  config.merge!(YAML.load_file("config/elasticsearch.yml")[Rails.env].deep_symbolize_keys)
end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
Thread.new do
  begin
    sleep(10)
    Pessoa.__elasticsearch__.create_index!
    Pessoa.__elasticsearch__.create_index! force: true
    Pessoa.import force: true 
    puts "==============================="
    puts "===Index elastcsearch criado==="
    puts "===Index elastcsearch criado==="
    puts "==============================="
  rescue
    puts "==============================="
    puts "==============================="
    puts "==============================="
    puts "=Elaticsearch não inicializado="
    puts "=Elaticsearch não inicializado="
    puts "==============================="
    puts "==============================="
    puts "==============================="
    #retry 
  end
end