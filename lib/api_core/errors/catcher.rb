module ApiCore
  module Errors
    class Catcher
      attr_reader :content, :status, :exception

      def initialize(opts = {})
        @exception = opts[:exception]
        @status = :unprocessible_entity
      end

      def process!
        @status = data[:status]
        if data[:method]
          send(:"#{data[:method]}")
        else
          @content = { error: data.slice(:message, :code) }
        end
      end

      private

      def wrap_error_message(message)
        @content = {
          error: {
            message: message,
            code: data[:code]
          }
        }
      end

      def data
        @data ||= ApiCore.config.exceptions.detect{|exc| exc[:class] ==  exception.class.to_s}
        @data ||= ApiCore.config.exceptions.detect{|exc| exc[:class] ==  'default'}
      end

      def unprocessable_entity_error
        wrap_error_message(exception || 'Unprocessable entity')
      end

      def record_invalid_error
        # TODO: Need Cresolve arrays
        @content = { errors: exception.record&.errors }
      end

      def default_error
        wrap_error_message(Rails.env.development? ? exception.message : 'Service temporary unavailable')
      end
    end
  end
end
