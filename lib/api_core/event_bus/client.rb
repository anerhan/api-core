module ApiCore
  module EventBus
    class Client
      class << self
        def async_broadcast(payload, opts = {})
          ::WaterDrop::AsyncProducer.call(prepare_payload(payload), opts)
        end

        def broadcast(payload, opts = {})
          ::WaterDrop::SyncProducer.call(prepare_payload(payload), opts)
        end

        def prepare_payload(payload)
          return payload if payload.is_a?(String)
          payload.to_json
        end
      end
    end
  end
end
