require 'elasticsearch/rails'
require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV.fetch('ES_URL') { 'http://localhost:9200/' },
  transport_options: {
    request: { timeout: 5 }
  }
)
