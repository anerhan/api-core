require 'waterdrop'
require 'kafka'

WaterDrop.setup do |config|
  config.deliver = true
  config.kafka.seed_brokers = ENV.fetch('KAFKA_HOSTS') { 'kafka://RL:9092' }.split("\s")
end
